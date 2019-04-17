//
//  String.swift
//  Movs
//
//  Created by BRQ on 17/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

extension String {
    
    func dateFormated() -> String {
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd"
        dateFormatterDate.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatterDate.date(from: self) else { return self }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}
