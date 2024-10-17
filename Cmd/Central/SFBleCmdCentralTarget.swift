//
//  SFBleCmdCentralTarget.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/16.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleCmdCentralTarget
public class SFBleCmdCentralTarget: SFBleCmdTarget {
    public var bleCentralManager: SFBleCentralManager!
    public override func execute() {
        if bleCentralManager == nil {
            return
        }
    }
}
