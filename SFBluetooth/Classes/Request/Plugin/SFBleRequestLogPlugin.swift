//
//  SFBleRequestLogPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/29.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

// MARK: - SFBleRequestLogPlugin
public class SFBleRequestLogPlugin: SFBleRequestPlugin {
    // 示例：Request[C]: readRssi > failure ? xxxx
    public func onStart(type: SFBleRequestType, msg: String?) {
        Log.debug("\(type.name) > start ? \(msg ?? "")")
    }
    public func onWaiting(type: SFBleRequestType, msg: String?) {
        Log.debug("\(type.name) > waiting ? \(msg ?? "")")
    }
    public func onDoing(type: SFBleRequestType, msg: String?) {
        Log.debug("\(type.name) > doing ? \(msg ?? "")")
    }
    public func onSuccess(type: SFBleRequestType, data: Any?, msg: String?) {
        Log.debug("\(type.name) > success ? \(msg ?? "") data=\(data ?? "nil")")
    }
    public func onFailure(type: SFBleRequestType, error: SFBleRequestError) {
        Log.debug("\(type.name) > failure ? error=\(error.msg)(\(error.code)) ")
    }
}

