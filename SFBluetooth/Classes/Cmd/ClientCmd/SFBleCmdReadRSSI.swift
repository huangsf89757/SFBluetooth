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
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        super.init(type: .client("readRSSI"), bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        blePeripheral.readRSSI(id: id)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) -> () {
        onSuccess(data: RSSI, msg: "读取RSSI成功。")
    }

}


