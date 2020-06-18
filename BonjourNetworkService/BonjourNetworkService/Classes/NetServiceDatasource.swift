//
//  NetServiceDatasource.swift
//  BonjourNetworkService
//
//  Created by Guru on 17/06/20.
//  Copyright © 2020 Gurumoorthy. All rights reserved.
//

import UIKit

/// Custom DAtasource by Using Anywhere in the project
class NetServiceDatasource: NSObject, UITableViewDataSource {
    
    var dataSource = [NetService]()// Which holds the All detected netservice
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NetServiceCell") as? NetServiceCell
        if cell == nil {
            tableView.register(UINib(nibName: "NetServiceCell", bundle: nil), forCellReuseIdentifier: "NetServiceCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "NetServiceCell") as? NetServiceCell
        }
        // Set data to the Detected netservice in the cell
        cell?.setDetectedNetServiceData(service: dataSource[indexPath.row])
        return cell ?? UITableViewCell()
    }
    

}
