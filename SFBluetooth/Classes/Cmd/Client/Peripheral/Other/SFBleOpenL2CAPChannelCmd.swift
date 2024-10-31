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
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, PSM: CBL2CAPPSM) {
        self.PSM = PSM
        super.init(name: "openL2CAPChannel", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: override
    public override func execute() {
        onStart(type: type)
        super.execute()
        blePeripheral.openL2CAPChannel(id: id, PSM: PSM)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidOpenChannel(peripheral: CBPeripheral, channel: CBL2CAPChannel?, error: (any Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.peripheral(.L2CAP(error.localizedDescription))))
        } else {
            onSuccess(type: type, data: channel, msg: "did open channel")
        }
    }
}

