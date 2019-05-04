//
//  FavoriteHelper.swift
//  Movs
//
//  Created by BRQ on 04/05/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class FavoriteHelper {
    
    private let db: FavoriteManager = FavoriteManager()
    
    public func validation(show: TvViewDataElement?, isFavorite: Bool, isFromDatabase: Bool, button: UIButton) {
        if isFromDatabase {
            favoriteValidationFromDB(isFavorite: isFavorite, button: button)
        } else {
            favoriteValidationFromSelected(show: show, isFavorite: isFavorite, button: button)
        }
    }
    
    private func favoriteValidationFromDB(isFavorite: Bool, button: UIButton) {
        if isFavorite {
            button.setImage(UIImage(named: Constants.viewImage.favorite), for: .normal)
        } else {
            button.setImage(UIImage(named: Constants.viewImage.notFavorite), for: .normal)
        }
    }
    
    private func favoriteValidationFromSelected(show: TvViewDataElement?, isFavorite: Bool, button: UIButton) {
        if !isFavorite {
            button.setImage(UIImage(named: Constants.viewImage.favorite), for: .normal)
            saveToDatabase(show: show)
        } else {
            button.setImage(UIImage(named: Constants.viewImage.notFavorite), for: .normal)
            deleteFromDatabase(show: show)
        }
    }
    
    private func saveToDatabase(show: TvViewDataElement?) {
        guard let viewData = show else { return }
        viewData.isFavorite = true
        self.db.save(element: viewData)
    }
    
    private func deleteFromDatabase(show: TvViewDataElement?) {
        guard let viewData = show else { return }
        viewData.isFavorite = false
        self.db.delete(element: viewData)
    }
}
