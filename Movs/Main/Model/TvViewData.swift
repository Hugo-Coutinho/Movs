//
//  TvViewData.swift
//  Movs
//
//  Created by BRQ on 31/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

typealias TvViewDataModel = [TvViewDataElement]

class TvViewDataElement {
    
    var titleTvShow,releaseDate,urlImage,description: String
    var isFavorite: Bool
    var genres: [String]?
    
    init(titleTvShow: String, releaseDate: String, description: String, urlImage:String, isFavorite: Bool, genres: [String]?) {
        self.titleTvShow = titleTvShow
        self.releaseDate = releaseDate
        self.urlImage = urlImage
        self.description = description
        self.isFavorite = isFavorite
        if let genres = genres {
        self.genres = genres
        }
    }
    
    class func newInstanceViewDataElement(element: Result) -> TvViewDataElement? {
        return TvViewDataElement(titleTvShow: element.originalName,
                                 releaseDate: element.firstAirDate,
                                 description: element.overview,
                                 urlImage: "https://image.tmdb.org/t/p/w500\(element.posterPath)",
            isFavorite: false,
            genres: [String]())
    }
    
}
