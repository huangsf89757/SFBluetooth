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
    public var isForce = false
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager) {
        super.init(name: "startScan", bleCentralManager: bleCentralManager)
    }
    
    // MARK: func
    public override func check() -> Bool {
        guard super.check() else {
            return false
        }
        if isForce {
            return true
        } else {
            if bleCentralManager.centralManager.isScanning {
                onSuccess(type: type, msg: "正在扫描中")
                return false
            } else {
                return true
            }
        }
    }
    public override func execute() {
        onStart(type: type)
        super.execute()
        bleCentralManager.scanForPeripherals(id: id, services: services, options: options)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    public override func centralManagerDidUpdateIsScanning(isScanning: Bool) {
        if isScanning {
            onSuccess(type: type)
        } else {
            onFailure(type: type, error: .client(.centralManager(.scan("扫描状态变更 isScanning=false"))))
        }
    }
//    public override func centralManagerDidDiscoverPeripheral(peripheral: CBPeripheral, advertisementData: [String : Any], RSSI: NSNumber) {
//        onSuccess(type: type, (peripheral, advertisementData, RSSI))
//    }
    
}
