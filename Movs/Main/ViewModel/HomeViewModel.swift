//
//  HomeViewModel.swift
//  Movs
//
//  Created by BRQ on 18/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelDelegate {
    func success()
    func loading()
    func error()
}

final class HomeViewModel {
    
    private enum StatesScreen:Int {
        case loading
        case error
        case success
        case unavailableError
    }
    
    private var states: StatesScreen = StatesScreen.loading
    var items = BehaviorRelay(value: TvViewDataModel())
    var allItems = TvViewDataModel()
    private let tvService = TvService()
    private let genresService = GenreService()
    private var delegate: HomeViewModelDelegate?
    let bag = DisposeBag()
    
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
        self.loading()
        fetchTvShows()
    }
}


// MARK: - SERVICE
extension HomeViewModel {
    private func fetchTvShows() {
        self.tvService.provideTVShows().subscribe {
            switch $0 {
            case .success(let element):
                self.acceptItems(results: element.results)
                self.success()
            case .error(let error):
                print(error)
                self.error()
            }
            }.disposed(by: self.bag)
    }
    
    private func fetchGenres(tvShowModel: TvViewDataModel, genresIDS: [String: [Int]]) {
        self.genresService.provideGenres().subscribe {
            switch $0 {
            case .success(let genresModel):
                let tvShows = Genre.setGenresForEachTvShows(tvShows: tvShowModel, genres: genresModel, genreIDS: genresIDS)
                self.allItems = tvShows
                self.items.accept(tvShows)
            case .error(let error):
                print(error)
            }
            }.disposed(by: self.bag)
    }
}


// MARK: - HELPER FUNCTIONS
extension HomeViewModel {
    
    private func acceptItems(results: [Result]) {
        self.parseToViewData(results: results)
    }
    
    private func parseToViewData(results: [Result]) {
        var model: TvViewDataModel = TvViewDataModel()
        var ids = [String: [Int]]()
        
        results.forEach { (result) in
            ids[result.originalName] = [Int]()
            ids[result.originalName]!.append(contentsOf: result.genreIDS)
            
            if let element = TvViewDataElement.newInstanceViewDataElement(element: result) {
                model.append(element)
            }
        }
        self.fetchGenres(tvShowModel: model, genresIDS: ids)
    }
}


// MARK: - VIEW STATES
extension HomeViewModel {
    
    private func success() {
        self.states = .success
        self.delegate?.success()
    }
    
    private func loading() {
        self.states = .loading
        self.delegate?.loading()
    }
    
    private func error() {
        self.states = .error
        self.delegate?.error()
    }
}

