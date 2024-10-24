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


// MARK: - SFBleCmdReadRSSI
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
        if let error = error {
            onFailure(error: .client(.peripheral(.readRSSI(error.localizedDescription))))
        } else {
            onSuccess(data: RSSI)
        }
    }
}


