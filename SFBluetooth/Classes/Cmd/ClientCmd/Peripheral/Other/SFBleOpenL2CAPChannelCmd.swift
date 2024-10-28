//
//  SFBleOpenL2CAPChannelCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/28.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleOpenL2CAPChannelCmd
public class SFBleOpenL2CAPChannelCmd: SFBlePeripheralCmd {
    // MARK: var
    public let PSM: CBL2CAPPSM
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, PSM: CBL2CAPPSM, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.PSM = PSM
        super.init(name: "openL2CAPChannel", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        blePeripheral.openL2CAPChannel(id: id, PSM: PSM)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidOpenChannel(peripheral: CBPeripheral, channel: CBL2CAPChannel?, error: (any Error)?) {
        if let error = error {
            onFailure(error: .client(.peripheral(.L2CAP(error.localizedDescription))))
        } else {
            onSuccess(data: channel)
        }
    }
}

