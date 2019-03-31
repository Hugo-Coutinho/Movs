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
    
    var items = BehaviorRelay(value: [Result]())
    private let bag = DisposeBag()
    private let service = TvService()
    
    
    init() {
        self.fetchTvShows()
    }
    
    
}

// MARK: - HELPER FUNCTIONS
extension HomeViewModel {
    private func fetchTvShows() {
        self.service.fetchTVShows().subscribe {
            switch $0 {
            case .success(let element):
                self.items.accept(element.results)
            case .error(let error):
                print(error)
            }
            }.disposed(by: self.bag)
    }
}
