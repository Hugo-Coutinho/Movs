//
//  TvService.swift
//  Movs
//
//  Created by BRQ on 20/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import RxSwift
import Moya


class TvService {
    
    private var provider = MoyaProvider<TheMovidedbAPI>()
    
    func loadTVShows(page: Int) {
        provider.rx.request(.getPopular()).subscribe { event in
            switch event {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                    let mapJson = try filteredResponse.map(TvModel.self)
                    print(mapJson)
                    
                } catch {
                    print(error)
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
