//
//  Pagination.swift
//  Movs
//
//  Created by BRQ on 10/06/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

class Pagination {
    var page: Int
    let totalAmountShows, totalPages: Int
    var isLoading: Bool
    
    init(page: Int, totalAmountShows: Int, totalPages: Int, isLoading: Bool) {
        self.page = page
        self.totalAmountShows = totalAmountShows
        self.totalPages = totalPages
        self.isLoading = isLoading
    }
}
