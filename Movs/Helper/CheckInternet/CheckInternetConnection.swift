//
//  CheckInternetService.swift
//
//  Created by Gilson Santos on 01/12/18.
//  Copyright © 2018 Hugo. All rights reserved.
//

import Foundation

class CheckInternetConnection {
    
    func connectionOk() throws -> Void {
        guard Reachability.isConnectedToNetwork() else {
            throw MyError.internet
        }
        return
    }
}
