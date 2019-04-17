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
    private var delegate: FavoriteViewModelDelegate!
    let bag = DisposeBag()
    
    
    init(view: FavoriteViewModelDelegate) {
        self.delegate = view
        validateAnimation()
    }
    
    func fetchFavorites() {
        favoriteList.accept(db.findAll())
    }
    
    func removeItemAt(index: Int) {
        db.delete(element: db.findAll()[index])
        fetchFavorites()
    }
    
    func validateAnimation() {
        let amount = db.findAll().count
        if amount > 0 {
            self.delegate?.FavoriteTvVisibility()
        } else {
            self.delegate?.setupAnimationVisibility(animationMode: Constants.LottieAnimation.empty, message: Constants.LottieAnimation.Message.emptyMessage)
        }
    }
}
