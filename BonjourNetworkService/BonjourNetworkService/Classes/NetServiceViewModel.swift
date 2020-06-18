//
//  NetServiceViewModel.swift
//  BonjourNetworkService
//
//  Created by Guru on 18/06/20.
//  Copyright © 2020 Gurumoorthy. All rights reserved.
//

import Foundation
import Network

class NetServiceViewModel {
    
    ///Append New service to NetService
    class func appendNewNetServiceToArray(_ services:[NetService],newDevice service:NetService) ->  [NetService]{
        var allNetServices = [NetService]()
        allNetServices = services
        if !allNetServices.contains(service) {
            allNetServices.append(service)
        }
        return allNetServices
    }
    ///Remove  New service which is not in connection
    class func removeNetServiceToArray(_ services:[NetService],Device service:NetService) ->  [NetService] {
        var allNetServices = [NetService]()
        allNetServices = services.filter({ (netSercvice) -> Bool in
            return netSercvice != service
        })
        return allNetServices
    }
    // MARK:- Fetch IP Address for the NetService Data
    class func getIpAddress(datas:[Data]) -> String{
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        for data in datas{
            data.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) -> Void in
                let sockaddrPtr = pointer.bindMemory(to: sockaddr.self)
                guard let unsafePtr = sockaddrPtr.baseAddress else { return }
                guard getnameinfo(unsafePtr, socklen_t(data.count), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 else {
                    return
                }
            }
            let ipAddress = String(cString:hostname)
            print("IP:\(ipAddress)")
            if let _ = IPv4Address(ipAddress) {
                debugPrint("\(ipAddress) is valid ipv4 address")
                if ipAddress != "127.0.0.1"{
                    return ipAddress
                }
            }
        }
        return ""
    }
    
    
}
