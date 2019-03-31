//
//  TvViewData.swift
//  Movs
//
//  Created by BRQ on 31/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

typealias Genres = [String]
typealias TvViewDataModel = [TvViewDataElement]

class TvViewDataElement {
    
    var titleMovie,releaseDate,description: String
    var isFavorite: Bool
    var genres: Genres
    
    init(titleMovie: String, releaseDate: String, description: String, isFavorite: Bool, genres: Genres) {
        self.titleMovie = titleMovie
        self.releaseDate = releaseDate
        self.description = description
        self.isFavorite = isFavorite
        self.genres = genres
    }
    
}

