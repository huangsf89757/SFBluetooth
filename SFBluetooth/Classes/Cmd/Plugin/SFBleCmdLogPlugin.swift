//
//  SFBleCmdLogPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

// MARK: - SFBleCmdLogPlugin
public class SFBleCmdLogPlugin: SFBleCmdPlugin {
    public func onStart(type: SFBleCmdType) {
        
    }
    public func onWaiting(type: SFBleCmdType) {}
    public func onDoing(type: SFBleCmdType) {}
    public func onSuccess(type: SFBleCmdType, data: Any?, msg: String?) {}
    public func onFailure(type: SFBleCmdType, error: SFBleError) {}
}
