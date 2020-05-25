//
//  GenreService.swift
//  Movs
//
//  Created by BRQ on 01/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import RxSwift
import Moya


class GenreService {
    
    private var provider = MoyaProvider<GenreRouter>()
    
    func provideGenres() -> PrimitiveSequence<SingleTrait, Genres> {
        return self.provider.rx.request(.getGenre)
            .filterSuccessfulStatusCodes()
            .map(Genres.self)
    }
}
