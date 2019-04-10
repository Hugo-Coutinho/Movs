//
//  FavoriteViewModel.swift
//  Movs
//
//  Created by BRQ on 09/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation


final class FavoriteViewModel {

    private var favoriteList: TvViewDataModel = TvViewDataModel()
    private var db: FavoriteManager = FavoriteManager()
    
    init() {
        favoriteList = db.findAll()
    }
}

