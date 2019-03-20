//
//  HomeViewModel.swift
//  Movs
//
//  Created by BRQ on 18/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class HomeViewModel {
    
    private var provider = MoyaProvider<TheMovidedbAPI>()
    
    func loadTVShows(page: Int) {
        
        provider.rx.request(.getPopular(page: page)).subscribe { event in
            switch event {
            case .success(let response):
                do {
                 let filteredResponse = try response.filterSuccessfulStatusAndRedirectCodes()
                let mapJson = try filteredResponse.mapJSON()
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
