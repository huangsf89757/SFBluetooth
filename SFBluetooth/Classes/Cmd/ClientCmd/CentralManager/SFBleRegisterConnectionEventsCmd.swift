//
//  SFBleRegisterConnectionEventsCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleRegisterConnectionEventsCmd
public class SFBleRegisterConnectionEventsCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var options: [CBConnectionEventMatchingOption : Any]?
    
    // MARK: life cycle
    public override init(name: String, bleCentralManager: SFBleCentralManager, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        super.init(name: "registerConnectionEvents", bleCentralManager: bleCentralManager, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        if #available(iOS 13.0, *) {
            bleCentralManager.registerForConnectionEvents(id: id, options: options)
        } else {
            onFailure(error: .client(.centralManager(.connectionEvent("iOS系统必须 >= 13.0"))))
        }
        onDoing()
    }
    
    // MARK: centralManager
    public override func centralManagerDidOccurConnectionEvents(peripheral: CBPeripheral, event: CBConnectionEvent) {
        onSuccess(data: (peripheral, event))
    }
    
}

