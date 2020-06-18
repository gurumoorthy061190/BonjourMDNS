//
//  NetService.swift
//  BonjourNetworkService
//
//  Created by Guru on 17/06/20.
//  Copyright © 2020 Gurumoorthy. All rights reserved.
//

import UIKit
import Foundation

/// Detecting & removing etservice for instant updating the data
protocol NetServiceDatasourceDelegate {
    func detectNewNetService(Service service:NetService)
    func removeNetService(Service service:NetService)
    func resolveNetServices(Service service:NetService,isMoreConfig:Bool)
}

//MARK:- NetServiceDelegates
class NetServiceClass : NSObject, NetServiceDelegate {
    ///Instance for singleton class
    static let shared = NetServiceClass()
    ///Netservice for publish & access all protocol inside the delegates
    var netService = NetService()
    ///Custom Delegate for to detact the new service
    var delegateNetService: NetServiceDatasourceDelegate?

    ///Publish the networkService with domain,type ,name & port
    func publishService(domain: String,Type type: String,Name name: String,Port port: Int32 ) {
        netService = NetService(domain: domain, type: type, name: name, port: port)
        netService.delegate = self
        netService.publish()
    }
    
    ///UnPublishInstance
    func unPublishInstance() {
        netService.stop()
    }
    
    ///Publish related delegates
    internal func netServiceWillPublish(_ sender: NetService) {
        print("netServiceWillPublish:\(sender)")
    }
    
    internal func netServiceDidPublish(_ sender: NetService) {
        print("netServiceDidPublish:\(sender)")
    }
    
    internal func netService(_ sender: NetService, didNotPublish errorDict: [String : NSNumber]) {
        print("didNotPublish:\(errorDict)")
    }
    
    ///Resolve service related delegates
    internal func netServiceWillResolve(_ sender: NetService) {
        print("netServiceWillResolve:\(sender)")
    }
    
    ///We can get exact ipAddress & port no by only calleing Didresolve
    internal func netServiceDidResolveAddress(_ sender: NetService) {
        print("netServiceDidResolveAddress:\(sender)")
        delegateNetService?.detectNewNetService(Service: sender)
    }
    
    internal func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("didNotResolve:\(sender)")
    }
    
    ///NstworkService Stop
    internal func netServiceDidStop(_ sender: NetService) {
           print("netServiceDidStop:\(sender)")
    }
    
    internal func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        print("didUpdateTXTRecord:\(sender)")
    }
        
    internal func netService(_ sender: NetService, didAcceptConnectionWith inputStream: InputStream, outputStream: OutputStream) {
        print("didAcceptConnectionWith:\(sender)")
    }
    
    ///By resolving Netservice provided
    func resolveNetService(service: NetService) {
        service.delegate = self
        service.resolve(withTimeout: 1.0)
    }
    
}
