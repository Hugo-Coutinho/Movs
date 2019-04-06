//
//  Reachability.swift
//  MeuTim
//
//  Copyright © 2016 Tim. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire

open class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
    class func checkTypeConnectionWWAN()->Bool{
        var WWAN = false
        let net = NetworkReachabilityManager()
        
        //let status = NetworkReachabilityManager()?.networkReachabilityStatus
        
        net?.startListening()
        
        let result = net?.isReachable
        
        if (result != nil && result!) {
            if (net?.isReachableOnEthernetOrWiFi)! {
                WWAN = false
            } else if (net?.isReachableOnWWAN)! {
                WWAN = true
            }
        }
        return WWAN
    }
    
}
