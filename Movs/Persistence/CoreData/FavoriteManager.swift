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
        if case let db as NSManagedObject = self.getFavorite(titleTvShow: element.titleTvShow) {
             self.context.delete(db)
            do {
                try self.saveDatabase()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func findAll() -> TvViewDataModel {
        guard let db = getFavoriteList() else { return TvViewDataModel() }
        return db.compactMap({ parseToElement(db: $0) })
    }
    
    func getCurrentFavorite(title: String) -> TvViewDataElement? {
        if let fav = self.getFavorite(titleTvShow: title) {
            return parseToElement(db: fav)
        }
        return nil
    }
}

// MARK: - HELPER FUNCTIONS
extension FavoriteManager {
    private func parseToElement(db: Favorite) -> TvViewDataElement {
     return TvViewDataElement(titleTvShow: db.titleTvShow ?? "",
                             releaseDate: db.releaseDate ?? "",
                             description: db.tvDescription ?? "",
                             urlImage: db.urlImage ?? "",
                             isFavorite: db.isFavorite,
                             genres: parseToGenre(db: db))
    }
    
    private func parseToGenre(db: Favorite) -> [String]? {
        return db.genres?.compactMap({ ($0 as! FavoriteGenre).name })
    }
    
    private func getFavoriteList() -> [Favorite]? {
        do {
            return try self.context.fetch(self.fetchRequest)
        } catch {
            return nil
        }
    }
    
    private func getFavoriteGenre(genres: [String], db: Favorite) {
        for currentGenre in genres {
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
            fetchRequest = Favorite.fetchRequest()
            if let db = result.first{
                return db
            }
        } catch {
            return nil
        }
        return nil
    }
}
