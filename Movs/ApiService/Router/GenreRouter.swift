//
//  GenreRouter.swift
//  Movs
//
//  Created by BRQ on 01/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import Moya


// https://api.themoviedb.org/3/genre/tv/list?api_key=8294d9700f85e20265086a49235ffbed

enum GenreRouter: TargetType {
    
    case getGenre()
    
    var baseURL: URL { return URL(string: Constants.Router.genreBaseUrl)! }
    
    var path: String {
        switch self {
        case .getGenre():
            return Constants.Router.getGenrePath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGenre():
            return .get
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getGenre():
            return URLEncoding.queryString
        }
    }
    
    var sampleData: Data { return Data() }
    
    var task: Task {
        switch self {
        case .getGenre():
            return .requestParameters(parameters: [Constants.Router.api_key: TmdbAPI.token], encoding: URLEncoding.default)
        }
    }
}
