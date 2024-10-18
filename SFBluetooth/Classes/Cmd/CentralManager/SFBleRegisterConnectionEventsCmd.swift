//
//  SFBleRegisterConnectionEventsCmd.swift
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


// MARK: - SFBleRegisterConnectionEventsCmd
public class SFBleRegisterConnectionEventsCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var options: [CBConnectionEventMatchingOption : Any]?
    
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
        if #available(iOS 13.0, *) {
            bleCentralManager.registerForConnectionEvents(id: id, options: options)
        } else {
            failure(.register("'registerForConnectionEvents(id:options:)' is only available in iOS 13.0 or newer."))
        }
    }
}

extension SFBleRegisterConnectionEventsCmd {
    private func addNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectionEventsRegister(_:)), name: SF_Notify_CentralManager_ConnectionEvents_Register, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectionEventsOccur(_:)), name: SF_Notify_CentralManager_ConnectionEvents_Occur, object: nil)
    }
    
    private func removeNotify() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notifyCentralManagerConnectionEventsRegister(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        if let options = userInfo["options"] as? [CBConnectionEventMatchingOption : Any] { }
        
        userInfo["order"] = order
        success(userInfo, "Start to register connection events.")
    }
    
    @objc private func notifyCentralManagerConnectionEventsOccur(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let event = userInfo["event"] as? CBConnectionEvent else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        
        order += 1
        userInfo["order"] = order
        success(userInfo, "Register the connection event succeeded.")
    }
}

