//
//  SFBleStopScanCmd.swift
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


// MARK: - SFBleStopScanCmd
public class SFBleStopScanCmd: SFBleCentralManagerCmd {
    // MARK: var
    
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
        bleCentralManager.stopScan(id: id)
    }
}

extension SFBleStopScanCmd {
    private func addNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerScanStop(_:)), name: SF_Notify_CentralManager_Scan_Stop, object: nil)
    }
    
    private func removeNotify() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notifyCentralManagerScanStop(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        
        userInfo["order"] = order
        success(userInfo, "Stop scanning successfully.")
    }
}

