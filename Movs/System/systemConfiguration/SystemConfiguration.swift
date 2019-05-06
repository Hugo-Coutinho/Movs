//
//  SystemConfiguration.swift
//  Movs
//
//  Created by BRQ on 05/05/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation


class SystemConfiguration {
    
    public class func configuration() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String

        return version
    }
}
