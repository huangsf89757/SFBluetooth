//
//  SFBleReadRSSICmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/19.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleReadRSSICmd
public class SFBleReadRSSICmd: SFBlePeripheralCmd {
    // MARK: var
    
    
    // MARK: life cycle
    public override init(success: @escaping SFBleCmdSuccess, failure: @escaping SFBleCmdFailure, blePeripheral: SFBlePeripheral) {
        super.init(success: success, failure: failure, blePeripheral: blePeripheral)
        addNotify()
    }
    deinit {
        removeNotify()
    }
    
    // MARK: excute
    public override func execute() {
        super.execute()
        blePeripheral.readRSSI(id: id)
    }
}

extension SFBleReadRSSICmd {
    private func addNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyPeripheralReadRSSIStart(_:)), name: SF_Notify_Peripheral_ReadRSSI_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyPeripheralReadRSSISuccess(_:)), name: SF_Notify_Peripheral_ReadRSSI_Success, object: nil)
    }
    
    private func removeNotify() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notifyPeripheralReadRSSIStart(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
       
    }
    
    @objc private func notifyPeripheralReadRSSISuccess(_ sender: Notification) {
        guard var userInfo = sender.userInfo else { return }
       
    }
}

