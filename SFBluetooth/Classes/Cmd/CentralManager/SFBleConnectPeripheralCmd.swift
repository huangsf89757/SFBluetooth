//
//  SFBleConnectPeripheralCmd.swift
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


// MARK: - SFBleConnectPeripheralCmd
public class SFBleConnectPeripheralCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var peripheral: CBPeripheral?
    public var options: [String : Any]?
    
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
            failure(.connect("peripheral is nil."))
            return
        }
        bleCentralManager.connect(id: id, peripheral: peripheral, options: options)
    }
}

extension SFBleConnectPeripheralCmd {
    private func addNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralStart(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralSuccess(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralFailure(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Failure, object: nil)
    }
    
    private func removeNotify() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notifyCentralManagerConnectPeripheralStart(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        
        userInfo["order"] = order
        success(userInfo, "Start to connect the peripheral.")
    }
    
    @objc private func notifyCentralManagerConnectPeripheralSuccess(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        
        order += 1
        userInfo["order"] = order
        success(userInfo, "The peripheral was successfully connected.")
    }
    
    @objc private func notifyCentralManagerConnectPeripheralFailure(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        
        order += 1
        userInfo["order"] = order
        var msg = "Failed to connect the peripheral."
        if let error = userInfo["error"] as? Error {
            msg += "\n" + "error: " + error.localizedDescription
        }
        failure(.connect(msg))
    }
}


