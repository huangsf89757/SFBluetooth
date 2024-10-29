//
//  SFBleClientCmd.swift
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


// MARK: - SFBleClientCmd
public class SFBleClientCmd: SFBleCmd {
    // MARK: life cycle
    public init(name: String) {
        super.init(type: .client(name))
    }
}

