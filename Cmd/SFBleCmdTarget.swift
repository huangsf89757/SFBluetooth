//
//  SFBleCmdTarget.swift
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


// MARK: - SFBleCmdTargetType
public enum SFBleCmdTargetType {
    // MARK: central
    case startScan
    case stopScan
    
    // MARK: peripheral
    
}


// MARK: - SFBleCmdTarget
public class SFBleCmdTarget {
    public var type: SFBleCmdTargetType!
    open func execute() {
        #warning("在具体的子类中实现")
    }
}
