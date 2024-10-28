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
    
    
    // MARK: life cycle
    public override init(name: String, bleCentralManager: SFBleCentralManager) {
        super.init(name: "stopScan", bleCentralManager: bleCentralManager)
    }
    
    // MARK: func
    public override func execute() {
        onStart()
        super.execute()
        bleCentralManager.stopScan(id: id)
        onDoing()
        onSuccess(data: nil)
    }
    
    // MARK: centralManager
    
    
}

