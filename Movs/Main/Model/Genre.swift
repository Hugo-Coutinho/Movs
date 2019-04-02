//
//  Genre.swift
//  Movs
//
//  Created by BRQ on 01/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation


struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
    
    static func setGenresForEachTvShows(tvShows: TvViewDataModel, genres: Genres, genreIDS: [String: [Int]]) -> TvViewDataModel {
        
        for (_, tvShow) in tvShows.enumerated() {
            if let genresIDS = genreIDS[tvShow.titleTvShow] {
                genresIDS.forEach { (id) in
                    if genres.genres.contains(where: { $0.id == id }) {
                        tvShow.genres?.append(genres.genres.filter({ $0.id == id }).map({ $0.name }).first!)
                    }
                }
            }
        }
        return tvShows
    }
}
