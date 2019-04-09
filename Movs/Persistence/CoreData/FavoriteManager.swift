//
//  FavoriteManager.swift
//  Movs
//
//  Created by BRQ on 09/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import CoreData

class FavoriteManager:MainCoreData {
    private var fetchRequest:NSFetchRequest<Favorite> = Favorite.fetchRequest()
    private var sortDescriptor = NSSortDescriptor(key: Constants.Persistence.sortDescriptor, ascending: true)
}

// MARK: - DATABASE FUNCTIONS
extension FavoriteManager {
    
    func save(element: TvViewDataElement) {
        let db = Favorite(context: self.context)
        db.titleTvShow = element.titleTvShow
        db.isFavorite = element.isFavorite
        db.releaseDate = element.releaseDate
        db.urlImage = element.urlImage
        db.tvDescription = element.description
        self.getFavoriteGenre(genres: element.genres!, db: db)
        do {
            try self.saveDatabase()
        } catch  {
            print(error)
        }
    }
    
    func delete(element: TvViewDataElement) {
        if let db = self.getFavorite(titleTvShow: element.titleTvShow) {
            self.context.delete(db)
            do {
                try self.saveDatabase()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - HELPER FUNCTIONS
extension FavoriteManager {
    private func getFavoriteGenre(genres: [String], db: Favorite) {
        for currentGenre in genres{
            let genreDB = FavoriteGenre(context: self.context)
            genreDB.name = currentGenre
            db.addToGenres(genreDB)
        }
    }
    
    private func getFavorite(titleTvShow: String) -> Favorite? {
        fetchRequest.predicate = NSPredicate(format: "titleTvShow == %@", titleTvShow)
        fetchRequest.sortDescriptors = [self.sortDescriptor]
        do {
            let result = try self.context.fetch(self.fetchRequest)
            if let db = result.first{
                return db
            }
        } catch {
            return nil
        }
        return nil
    }
}
