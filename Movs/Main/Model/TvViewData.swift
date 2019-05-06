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
    
    class func parseJsonObjectToElement(jsonObject: [[String: Any]]?) -> TvViewDataModel {
        var model = TvViewDataModel()
        jsonObject?.forEach({
            if let name = $0["name"] as? String, let date = $0["first_air_date"] as? String,
                let description = $0["overview"] as? String, let urlImage = $0["poster_path"] as? String {
                
                let element = TvViewDataElement(titleTvShow: name, releaseDate: date, description: description, urlImage: urlImage, isFavorite: false, genres: ["action","drama"])
                model.append(element)
            }
        })
        return model
    }
    
    class func newInstanceViewDataElement(element: Result) -> TvViewDataElement? {
        return TvViewDataElement(titleTvShow: element.originalName,
                                 releaseDate: element.firstAirDate,
                                 description: element.overview,
                                 urlImage: "\(Constants.Router.ImageBaseUrl)\(element.posterPath)",
            isFavorite: false,
            genres: [String]())
    }
}
