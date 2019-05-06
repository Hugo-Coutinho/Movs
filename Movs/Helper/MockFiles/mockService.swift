//
//  services.swift
//  Movs
//
//  Created by BRQ on 04/05/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

class mockService {
    
    func loadFromMock() -> [TvViewDataElement]? {
        let fileUrl = Bundle.main.url(forResource: "tvShows.json", withExtension: nil)!
        let jsonData = try! Data(contentsOf: fileUrl)
        
        if let array = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String: Any]] {
            return TvViewDataElement.parseJsonObjectToElement(jsonObject: array)
        }
        return nil
    }
    
}
