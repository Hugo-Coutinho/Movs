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

final class HomeViewModel {
    
    var items = BehaviorRelay(value: TvViewDataModel())
    private let tvService = TvService()
    private let genresService = GenreService()
    let bag = DisposeBag()
    
    init() {
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
            case .error(let error):
                print(error)
            }
            }.disposed(by: self.bag)
    }
    
    private func fetchGenres(tvShowModel: TvViewDataModel, genresIDS: [String: [Int]]) {
        self.genresService.provideGenres().subscribe {
            switch $0 {
            case .success(let genresModel):
                let tvShows = Genre.setGenresForEachTvShows(tvShows: tvShowModel, genres: genresModel, genreIDS: genresIDS)
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



