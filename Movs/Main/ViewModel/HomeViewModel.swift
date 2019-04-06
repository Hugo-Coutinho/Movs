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
    func successRequest()
    func setupAnimation(animationMode: String, message: String)
}

final class HomeViewModel {
    
    var items = BehaviorRelay(value: TvViewDataModel())
    var allItems = TvViewDataModel()
    private let tvService = TvService()
    private let genresService = GenreService()
    private var delegate: HomeViewModelDelegate?
    let bag = DisposeBag()
    
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
        
        do {
            
            try CheckInternetConnection().connectionOk()
            
        self.delegate?.setupAnimation(animationMode: Constants.LottieAnimation.loading, message: Constants.LottieAnimation.Message.loadingMessage)
        fetchTvShows()
            
        } catch {
            self.delegate?.setupAnimation(animationMode: Constants.LottieAnimation.offline, message: Constants.LottieAnimation.Message.offlineMessage)
        }
    }
}


// MARK: - SERVICE
extension HomeViewModel {
    private func fetchTvShows() {
        self.tvService.provideTVShows().subscribe {
            switch $0 {
            case .success(let element):
                self.acceptItems(results: element.results)
                self.delegate?.successRequest()
            case .error(let error):
                print(error)
                self.delegate?.setupAnimation(animationMode: Constants.LottieAnimation.error, message: Constants.LottieAnimation.Message.errorMessage)
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
