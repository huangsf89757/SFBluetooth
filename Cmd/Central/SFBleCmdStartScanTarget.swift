//
//  SFBleCmdStartScanTarget.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/16.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

public class SFBleCmdStartScanTarget: SFBleCmdCentralTarget {
    // MARK: var
    public var services: [CBUUID]?
    public var options: [String: Any]?
    public var isForce: Bool = true
    
    // MARK: life cycle
    override init() {
        super.init()
        type = .startScan
    }
    
    // MARK: func
    public override func execute() {
        super.execute()
        if isForce {
//            bleCentralManager.stopScan()
        } else if bleCentralManager.centralManager.isScanning {
            // log
            return
        }
//        bleCentralManager.scanForPeripherals(id: <#String#>, services: services, options: options)
    }
}
