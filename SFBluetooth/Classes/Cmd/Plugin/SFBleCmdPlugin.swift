//
//  SFBleCmdPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation

// MARK: - SFBleCmdPlugin
public protocol SFBleCmdPlugin {
    func onStart(type: SFBleCmdType, msg: String?)
    func onWaiting(type: SFBleCmdType, msg: String?)
    func onDoing(type: SFBleCmdType, msg: String?)
    func onSuccess(type: SFBleCmdType, data: Any?, msg: String?)
    func onFailure(type: SFBleCmdType, error: SFBleError)
}

extension SFBleCmdPlugin {
    func onStart(type: SFBleCmdType, msg: String?) {}
    func onWaiting(type: SFBleCmdType, msg: String?) {}
    func onDoing(type: SFBleCmdType, msg: String?) {}
    func onSuccess(type: SFBleCmdType, data: Any?, msg: String?) {}
    func onFailure(type: SFBleCmdType, error: SFBleError) {}
}
