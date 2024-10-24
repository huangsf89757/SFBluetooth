//
//  SFBleStartScanCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleStartScanCmd
public class SFBleStartScanCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var services: [CBUUID]?
    public var options: [String: Any]?
    
    // MARK: life cycle
    public override init(name: String, bleCentralManager: SFBleCentralManager, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        super.init(name: "startScan", bleCentralManager: bleCentralManager, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        bleCentralManager.scanForPeripherals(id: id, services: services, options: options)
        onDoing()
    }
    
    // MARK: centralManager
    public override func centralManagerDidDiscoverPeripheral(peripheral: CBPeripheral, advertisementData: [String : Any], RSSI: NSNumber) {
        onSuccess(data: (peripheral, advertisementData, RSSI))
    }
    
}
