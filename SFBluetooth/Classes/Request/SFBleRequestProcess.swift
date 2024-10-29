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
    func onStart(msg: String?)
    func onDoing(msg: String?)
    func onSuccess(data: Any?, msg: String?)
    func onFailure(error: SFBleCmdError)
}


