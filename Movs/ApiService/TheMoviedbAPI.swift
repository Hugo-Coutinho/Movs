//
//  TheMoviedbAPI.swift
//  Movs
//
//  Created by BRQ on 18/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import Moya

struct TmdbAPI {
    static let token = "8294d9700f85e20265086a49235ffbed"
}
// URL:   https://api.themoviedb.org/3/tv/popular?api_key=8294d9700f85e20265086a49235ffbed
enum TheMovidedbAPI: TargetType {
    
    case getPopular()
    
    var baseURL: URL { return URL(string: "https://api.themoviedb.org/3/tv/")! }
    
    var path: String {
        switch self {
        case .getPopular:
            return "popular"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPopular():
            return .get
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
      var parameterEncoding: ParameterEncoding {
        switch self {
        case .getPopular():
            return URLEncoding.queryString
        }
    }
    
    var sampleData: Data { return Data() }
    
    var task: Task {
        switch self {
        case .getPopular():
            return .requestParameters(parameters: ["api_key": TmdbAPI.token], encoding: URLEncoding.default)
        }
    }
    
}
