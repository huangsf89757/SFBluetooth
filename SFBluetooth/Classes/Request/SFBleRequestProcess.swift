//
//  SFBleRequestProcess.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/29.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleRequestProcess
public protocol SFBleRequestProcess {
    func onStart(type: SFBleRequestType, msg: String?)
    func onDoing(type: SFBleRequestType, cmd: SFBleCmd, msg: String?)
    func onSuccess(type: SFBleRequestType, data: Any?, msg: String?, isDone: Bool)
    func onFailure(type: SFBleRequestType, error: SFBleRequestError)
}

public extension SFBleRequestProcess {
    func onStart(type: SFBleRequestType, msg: String?) {}
    func onDoing(type: SFBleRequestType, cmd: SFBleCmd, msg: String?) {}
    func onSuccess(type: SFBleRequestType, data: Any?, msg: String?, isDone: Bool) {}
    func onFailure(type: SFBleRequestType, error: SFBleRequestError) {}
}


