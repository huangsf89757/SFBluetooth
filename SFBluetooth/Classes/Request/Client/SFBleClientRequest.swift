//
//  SFBleClientRequest.swift
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


// MARK: - SFBleClientRequest
public class SFBleClientRequest: SFBleRequest {
    // MARK: life cycle
    public init(name: String) {
        super.init(type: .client(name))
    }
}
