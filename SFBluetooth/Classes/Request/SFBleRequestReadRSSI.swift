//
//  SFBleRequestReadRSSI.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleRequest
public class SFBleRequestReadRSSI: SFBleRequest {
    // MARK: func
    public override func excute() {
        super.excute()
        let centralManagerState = bleCentralManager.centralManager.state
        guard centralManagerState == .poweredOn else {
            failure(.centralManager(.state("蓝牙未开启。state: \(centralManagerState.sf.description)")))
            return
        }
        let isScanning = bleCentralManager.centralManager.isScanning
        if isScanning {
            failure(.centralManager(.isScanning("当前扫描中，请先停止扫描。")))
            return
        }
        let peripheralState = blePeripheral.peripheral.state
        guard peripheralState == .connected else {
            failure(.centralManager(.connectPeripheral("外设不在连接中。state: \(peripheralState.sf.description)")))
            return
        }
        blePeripheral.readRSSI(id: id)
        doing()
    }
    
    // MARK: centralManager
    public override func centralManagerDidUpdateState(state: CBManagerState) {
        if state != .poweredOn {
            failure(.centralManager(.state("蓝牙未开启。state: \(state.sf.description)")))
        }
    }
    public override func centralManagerDidUpdateIsScanning(isScanning: Bool) {
        if isScanning {
            failure(.centralManager(.isScanning("当前处于扫描状态。")))
        }
    }
    
    // MARK: peripheral
    public override func peripheralDidUpdateState(peripheral: CBPeripheral, state: CBPeripheralState) -> () {
        if state != .connected {
            failure(.centralManager(.connectPeripheral("外设不在连接中。state: \(state.sf.description)")))
            return
        }
    }
    public override func peripheralDidReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) -> () {
        success(RSSI, "读取RSSI成功。")
    }

}

