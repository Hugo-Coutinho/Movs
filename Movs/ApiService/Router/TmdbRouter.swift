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
    static let token = Constants.token
}
// URL:   https://api.themoviedb.org/3/tv/popular?api_key=8294d9700f85e20265086a49235ffbed
enum TmdbRouter: TargetType {
    
    case getPopular(page: Int)
    
    var baseURL: URL { return URL(string: Constants.Router.tvBaseURL)! }
    
    var path: String {
        switch self {
        case .getPopular:
            return Constants.Router.getPopularPath
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPopular(_):
            return .get
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
      var parameterEncoding: ParameterEncoding {
        switch self {
        case .getPopular(_):
            return URLEncoding.queryString
        }
    }
    
    var sampleData: Data { return Data() }
    
    var task: Task {
        switch self {
        case .getPopular(let page):
            let parameters: [String: Any] = [Constants.Router.api_key: TmdbAPI.token, Constants.Router.page: page]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
}
