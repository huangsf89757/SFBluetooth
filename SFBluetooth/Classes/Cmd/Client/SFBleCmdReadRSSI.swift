//
//  SFBleCmdReadRSSI.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleCmd
public class SFBleCmdReadRSSI: SFBleClientCmd {
    // MARK: func
    public override func excute() {
        super.excute()
        blePeripheral.readRSSI(id: id)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) -> () {
        success(RSSI, "读取RSSI成功。")
    }

}


