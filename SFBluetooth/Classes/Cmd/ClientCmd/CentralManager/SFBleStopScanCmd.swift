//
//  SFBleStopScanCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleStopScanCmd
public class SFBleStopScanCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var isForce = false
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager) {
        super.init(name: "stopScan", bleCentralManager: bleCentralManager)
    }
    
    // MARK: func
    public override func check() -> Bool {
        guard super.check() else {
            return false
        }
        if isForce {
            return true
        } else {
            if !bleCentralManager.centralManager.isScanning {
                onSuccess(type: type, msg: "已经停止扫描")
                return false
            } else {
                return true
            }
        }
    }
    public override func execute() {
        onStart(type: type)
        super.execute()
        bleCentralManager.stopScan(id: id)
        onDoing(type: type)
        onSuccess(type: type)
    }
    
    // MARK: centralManager
    public override func centralManagerDidUpdateIsScanning(isScanning: Bool) {
        if !isScanning {
            onSuccess(type: type)
        } else {
            onFailure(type: type, error: .client(.centralManager(.scan("扫描状态变更 isScanning=true"))))
        }
    }
    
}

