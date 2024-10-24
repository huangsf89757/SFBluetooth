//
//  SFBleDisconnectPeripheralCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleDisconnectPeripheralCmd
public class SFBleDisconnectPeripheralCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var peripheral: CBPeripheral?
    
    // MARK: life cycle
    public override init(name: String, bleCentralManager: SFBleCentralManager, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        super.init(name: "connectPeripheral", bleCentralManager: bleCentralManager, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        guard let peripheral = peripheral else {
            onFailure(error: .client(.centralManager(.discoverPeripheral("peripheral = nil"))))
            return
        }
        bleCentralManager.disconnect(id: id, peripheral: peripheral)
        onDoing()
    }
    
    // MARK: centralManager
    public override func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, error: (Error)?) {
        onSuccess(data: nil, msg: error?.localizedDescription)
    }
    public override func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (Error)?) {
        onSuccess(data: nil, msg: error?.localizedDescription)
    }
    
}
