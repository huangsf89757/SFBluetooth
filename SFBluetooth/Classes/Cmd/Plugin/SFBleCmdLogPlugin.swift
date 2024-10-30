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
    // 示例：Cmd[C]: readRssi > failure ? xxxx
    public func onStart(type: SFBleCmdType, msg: String?) {
        Log.debug("\(type.name) > start ? \(msg ?? "")")
    }
    public func onWaiting(type: SFBleCmdType, msg: String?) {
        Log.debug("\(type.name) > waiting ? \(msg ?? "")")
    }
    public func onDoing(type: SFBleCmdType, msg: String?) {
        Log.debug("\(type.name) > doing ? \(msg ?? "")")
    }
    public func onSuccess(type: SFBleCmdType, data: Any?, msg: String?, isDone: Bool) {
        Log.debug("\(type.name) > success\(isDone ? "" : "[ing]") ? \(msg ?? "") data=\(data ?? "nil")")
    }
    public func onFailure(type: SFBleCmdType, error: SFBleCmdError) {
        Log.debug("\(type.name) > failure ? error=\(error.msg)(\(error.code)) ")
    }
}
