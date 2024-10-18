//
//  SFBleDisconnectPeripheralCmd.swift
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


// MARK: - SFBleDisconnectPeripheralCmd
public class SFBleDisconnectPeripheralCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var peripheral: CBPeripheral?
    
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
        guard let peripheral = peripheral else {
            failure(.connect("peripheral is nil"))
            return
        }
        bleCentralManager.disconnect(id: id, peripheral: peripheral)
    }
}

extension SFBleDisconnectPeripheralCmd {
    private func addNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralStart(_:)), name: SF_Notify_CentralManager_DisconnectPeripheral_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralSuccess(_:)), name: SF_Notify_CentralManager_DisconnectPeripheral_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralAutoReconnectSuccess(_:)), name: SF_Notify_CentralManager_DisconnectPeripheralAutoReconnect_Success, object: nil)
    }
    
    private func removeNotify() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralStart(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        
        userInfo["order"] = order
        success(userInfo, "Start to disconnect the peripheral.")
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralSuccess(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        
        order += 1
        userInfo["order"] = order
        var msg = "Disconnect the peripheral successfully."
        if let error = userInfo["error"] as? Error {
            msg += "\n" + "error: " + error.localizedDescription
        }
        success(userInfo, msg)
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralAutoReconnectSuccess(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        guard let timestamp = userInfo["timestamp"] as? CFAbsoluteTime else { return }
        guard let isReconnecting = userInfo["isReconnecting"] as? Bool else { return }
        
        order += 1
        userInfo["order"] = order
        var msg = "Disconnect the peripheral successfully, then reconnect automatically."
        if let error = userInfo["error"] as? Error {
            msg += "\n" + "error: " + error.localizedDescription
        }
        success(userInfo, msg)
    }
}

