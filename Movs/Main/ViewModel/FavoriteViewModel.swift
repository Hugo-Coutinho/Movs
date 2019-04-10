//
//  FavoriteViewModel.swift
//  Movs
//
//  Created by BRQ on 09/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class FavoriteViewModel {
    
    var favoriteList = BehaviorRelay(value: TvViewDataModel())
    private var db: FavoriteManager = FavoriteManager()
    let bag = DisposeBag()
    
    func fetchFavorites() {
        favoriteList.accept(db.findAll())
    }
}


