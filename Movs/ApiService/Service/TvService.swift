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
    
    private var provider = MoyaProvider<TmdbRouter>()
    
    func provideTVShows() -> PrimitiveSequence<SingleTrait, TvModel> {
        return self.provider.rx.request(.getPopular())
            .filterSuccessfulStatusCodes()
            .map(TvModel.self)
    }
}

