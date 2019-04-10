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

protocol FavoriteViewModelDelegate {
    func FavoriteTvVisibility()
    func setupAnimationVisibility(animationMode: String, message: String)
}

final class FavoriteViewModel {
    
    var favoriteList = BehaviorRelay(value: TvViewDataModel())
    var db: FavoriteManager = FavoriteManager()
    private var delegate: FavoriteViewModelDelegate?
    let bag = DisposeBag()
    
    func attach(view: FavoriteViewModelDelegate) {
        self.delegate = view
    }
    
    init() {
        let amount = db.findAll().count
        if amount > 0 {
            self.delegate?.FavoriteTvVisibility()
        } else {
            self.delegate?.setupAnimationVisibility(animationMode: Constants.LottieAnimation.notFound, message: "favorites not found it")
        }
    }
    
    func fetchFavorites() {
        favoriteList.accept(db.findAll())
    }
}


