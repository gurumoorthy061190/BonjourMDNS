//
//  NetServiceCell.swift
//  BonjourNetworkService
//
//  Created by Guru on 17/06/20.
//  Copyright © 2020 Gurumoorthy. All rights reserved.
//

import UIKit
import Foundation

//MARK:- Custom Tableview cell
class NetServiceCell: UITableViewCell {
    
    @IBOutlet weak var labelDeviceName: UILabel!
    @IBOutlet weak var labelIpAddress: UILabel!
    @IBOutlet weak var labelPortNo: UILabel!
    @IBOutlet weak var labelType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // To assign the Netservice value to the label in cell
    func setDetectedNetServiceData(service: NetService) {
        labelType.text = ": \(service.type)"
        labelDeviceName.text = ": \(service.name)"
        labelPortNo.text = ": \(service.port)"
        labelIpAddress.text = ": \(NetServiceViewModel.getIpAddress(datas: service.addresses ?? []))"
            
    }
}
