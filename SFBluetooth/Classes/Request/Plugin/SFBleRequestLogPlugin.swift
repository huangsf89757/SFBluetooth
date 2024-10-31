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
    func onStart(type: SFBleRequestType, msg: String?) {
        Log.debug("\(type.name) > start ? \(msg ?? "")")
    }
    func onWaiting(type: SFBleRequestType, msg: String?) {
        Log.debug("\(type.name) > waiting ? \(msg ?? "")")
    }
    func onDoing(type: SFBleRequestType, msg: String?) {
        Log.debug("\(type.name) > doing ? \(msg ?? "")")
    }
    func onSuccess(type: SFBleRequestType, data: Any?, msg: String?, isDone: Bool) {
        Log.debug("\(type.name) > success\(isDone ? "" : "[ing]") ? \(msg ?? "") data=\(data ?? "nil")")
    }
    func onFailure(type: SFBleRequestType, error: SFBleRequestError) {
        Log.debug("\(type.name) > failure ? error=\(error.msg)(\(error.code)) ")
    }
}

