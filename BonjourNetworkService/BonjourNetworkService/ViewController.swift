//
//  ViewController.swift
//  BonjourNetworkService
//
//  Created by Guru on 17/06/20.
//  Copyright © 2020 Gurumoorthy. All rights reserved.
//

import UIKit
import Foundation

//MARK:- View Controller
class ViewController: UIViewController, NetServiceDatasourceDelegate {
    
    ///Connection from storyboard
    @IBOutlet var buttonPublish: UIButton!
    @IBOutlet var buttonScan: UIButton!
    @IBOutlet var tableNetServiceList: UITableView!
    @IBOutlet var imageNoData: UIImageView!
    
    ///Datsources for laoding Tab;e
    var datasource = NetServiceDatasource()
    var duplicateDataSource = [NetService]()// Which holds the All detected netservice
    
    ///Variable Assignemnt for Service Publish
    let serviceDomainData = (domainName: "local",type: "_http._tcp.",deviceName: UIDevice.current.name,portNumber: 8080)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadIntialSetUp()
    }
    
    /// Load Initial setup
    func loadIntialSetUp() {
        tableNetServiceList.dataSource = datasource // Initial Datasource Assign to the TableView
        NetServiceBrowserClass.shared.delegateDataSource = self // Delegate for gettting newNetservice & expired services from netservice Class
        NetServiceClass.shared.delegateNetService = self
        tableNetServiceList.tableFooterView = UIView()
    }
    
    ///Publish New device to netservice to access
    @IBAction func publishButtonAction(_ sender:UIButton) {
        NetServiceClass.shared.publishService(domain: serviceDomainData.domainName, Type: serviceDomainData.type, Name: serviceDomainData.deviceName, Port: Int32(serviceDomainData.portNumber))
    }
    
    ///Scan any device is available in netservices
    @IBAction func scanButtonAction(_ sender:UIButton) {
        NetServiceBrowserClass.shared.searchNetService(Type: serviceDomainData.type, Domain: serviceDomainData.domainName)
    }
    
    ///To resove the NetService
    func resolveNetServices(Service service: NetService, isMoreConfig: Bool) {
        duplicateDataSource.append(service)
        if !isMoreConfig {
            for service in duplicateDataSource {
                NetServiceClass.shared.resolveNetService(service: service)
            }
        }
    }
    
    ///Append new device which is published in netservice
    func detectNewNetService(Service service: NetService) {
        datasource.dataSource = NetServiceViewModel.appendNewNetServiceToArray(datasource.dataSource, newDevice: service)
        imageNoData.isHidden = !datasource.dataSource.isEmpty
        tableNetServiceList.reloadData()
    }
    
    ///Remove Existing Device or netservice Which is in Netservices
    func removeNetService(Service service: NetService) {
        datasource.dataSource = NetServiceViewModel.removeNetServiceToArray(datasource.dataSource, Device: service)
        duplicateDataSource = datasource.dataSource
        imageNoData.isHidden = !datasource.dataSource.isEmpty
        tableNetServiceList.reloadData()
    }
    
}

