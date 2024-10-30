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
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral) {
        super.init(name: "readRSSI", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: func
    public override func execute() {
        onStart(type: type)
        super.execute()
        blePeripheral.readRSSI(id: id)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidReadRssi(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) -> () {
        if let error = error {
            onFailure(type: type, error: .client(.peripheral(.read(.rssi(error.localizedDescription)))))
        } else {
            onSuccess(type: type, data: RSSI, msg: "did read rssi")
        }
    }
}
