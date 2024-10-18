//
//  SFBleStartScanCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/18.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleStartScanCmd
public class SFBleStartScanCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var services: [CBUUID]?
    public var options: [String: Any]?
    
    // MARK: life cycle
    public override init(success: @escaping SFBleCmdSuccess, failure: @escaping SFBleCmdFailure, bleCentralManager: SFBleCentralManager) {
        super.init(success: success, failure: failure, bleCentralManager: bleCentralManager)
        addNotify()
    }
    deinit {
        removeNotify()
    }
    
    // MARK: excute
    public override func execute() {
        super.execute()
        bleCentralManager.scanForPeripherals(id: id, services: services, options: options)
    }
}

extension SFBleStartScanCmd {
    private func addNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerScanStart(_:)), name: SF_Notify_CentralManager_Scan_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDidDiscoverPeripheral(_:)), name: SF_Notify_CentralManager_DidDiscoverPeripheral, object: nil)
    }
    
    private func removeNotify() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notifyCentralManagerScanStart(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        if let serviceUUIDs = userInfo["serviceUUIDs"] as? [CBUUID] {  }
        if let options = userInfo["options"] as? [String: Any] {  }
        
        userInfo["order"] = order
        success(userInfo, "Start scan successfully.")
    }
    
    @objc private func notifyCentralManagerDidDiscoverPeripheral(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        guard let advertisementData = userInfo["advertisementData"] as? [String : Any] else { return }
        guard let RSSI = userInfo["RSSI"] as? NSNumber else { return }
        
        order += 1
        userInfo["order"] = order
        success(userInfo, "Did discover peripheral.")
    }
}
