//
//  SFBleReadRssiCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleReadRssiCmd
public class SFBleReadRssiCmd: SFBlePeripheralCmd {
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        super.init(name: "readRSSI", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func execute() {
        onStart()
        super.execute()
        blePeripheral.readRSSI(id: id)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) -> () {
        if let error = error {
            onFailure(error: .client(.peripheral(.read(.rssi(error.localizedDescription)))))
        } else {
            onSuccess(data: RSSI)
        }
    }
}
