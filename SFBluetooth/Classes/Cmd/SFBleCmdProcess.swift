//
//  SFBleCmdProcess.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/29.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleCmdProcess
public protocol SFBleCmdProcess {
    func onStart(type: SFBleCmdType, msg: String?)
    func onDoing(type: SFBleCmdType, msg: String?)
    func onSuccess(type: SFBleCmdType, data: Any?, msg: String?, isDone: Bool)
    func onFailure(type: SFBleCmdType, error: SFBleCmdError)
}

public extension SFBleCmdProcess {
    func onStart(type: SFBleCmdType, msg: String?) {}
    func onDoing(type: SFBleCmdType, msg: String?) {}
    func onSuccess(type: SFBleCmdType, data: Any?, msg: String?, isDone: Bool) {}
    func onFailure(type: SFBleCmdType, error: SFBleCmdError) {}
}
