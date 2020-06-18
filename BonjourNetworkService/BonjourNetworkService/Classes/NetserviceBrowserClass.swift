//
//  NetserviceBrowserClass.swift
//  BonjourNetworkService
//
//  Created by Guru on 18/06/20.
//  Copyright © 2020 Gurumoorthy. All rights reserved.
//

import Foundation

//MARK:- NetServiceBrowserDelegate
class NetServiceBrowserClass: NSObject, NetServiceBrowserDelegate {
    ///Instance for singleton class
    static let shared = NetServiceBrowserClass()
    ///Browser help to find new published device within range
    var searchNetService = NetServiceBrowser()
    ///Custom Delegate for to detect the new service
    var delegateDataSource: NetServiceDatasourceDelegate?
    
    ///Search Service is any availble
    func searchNetService(Type type:String,Domain domain:String) {
        searchNetService.stop()
        searchNetService.delegate = self
        searchNetService.searchForServices(ofType: type, inDomain: domain)
    }
    
    internal func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserWillSearch:\(browser)")
    }
    
    ///Find delegate provide service which are published
    internal func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        print("didFindService:\(service.name), MoreComing:\(moreComing)")
        delegateDataSource?.resolveNetServices(Service: service, isMoreConfig: moreComing)
    }
    
    internal func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        print("didNotSearch:\(browser), ERROR:\(errorDict)")
    }
    
    ///remove netservice which is in Already published
    internal func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        print("didRemove:\(service.name), MoreComing:\(moreComing)")
        delegateDataSource?.removeNetService(Service: service)
    }
    
    internal func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        print("didFindDomain:\(domainString), MoreComing:\(moreComing)")
    }
    
    internal func netServiceBrowser(_ browser: NetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool) {
        print("didRemoveDomain:\(domainString), MoreComing:\(moreComing)")
    }
     
    internal func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        print("didRemoveDomain:\(browser)")
    }
    
}
