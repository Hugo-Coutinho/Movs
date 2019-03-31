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
    private let service = TvService()
    private var viewDataModel = TvViewDataModel()
    let bag = DisposeBag()
    
    init() {
        fetchTvShows()
    }
}


// MARK: - SERVICE
extension HomeViewModel {
  private func fetchTvShows() {
        self.service.provideTVShows().subscribe {
            switch $0 {
            case .success(let element):
                let viewDataModel = self.parseToViewData(results: element.results)
                self.items.accept(viewDataModel)
            case .error(let error):
                print(error)
            }
            }.disposed(by: self.bag)
    }
}


// MARK: - HELPER FUNCTIONS
extension HomeViewModel {
    
    private func newInstanceViewDataElement(element: Result) -> TvViewDataElement? {
        return TvViewDataElement(titleMovie: element.originalName,
                                 releaseDate: element.firstAirDate,
                                 description: element.overview,
                                 isFavorite: false,
                                 genres: [String]())
    }
    
    private func parseToViewData(results: [Result]) -> TvViewDataModel {
        var model = TvViewDataModel()
    
            results.forEach { (result) in
                if let element = newInstanceViewDataElement(element: result) {
                    model.append(element)
            }
        }
        return model
    }
}



