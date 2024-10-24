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
    public func onStart(type: SFBleCmdType, msg: String?) {
        Log.debug("[\(type.description)]: start \(msg)")
    }
    public func onWaiting(type: SFBleCmdType, msg: String?) {
        Log.debug("[\(type.description)]: waiting \(msg)")
    }
    public func onDoing(type: SFBleCmdType, msg: String?) {
        Log.debug("[\(type.description)]: doing \(msg)")
    }
    public func onSuccess(type: SFBleCmdType, data: Any?, msg: String?) {
        Log.debug("[\(type.description)]: success \(msg)")
    }
    public func onFailure(type: SFBleCmdType, error: SFBleError) {
        Log.debug("[\(type.description)]: failure \(error.msg)")
    }
}
