//
//  SFBleStep.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/19.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

// MARK: - SFBleStep
public enum SFBleStep {
    // start
    case start
    // centralManager
    case startScan
    case stopScan
    case connect
    case disconnect
    case registerEvents
    // peripheral
    case readRSSI
    case discoverServices
    case discoverIncludedServices
    case discoverCharacteristics
    case readCharacteristicValue
    case writeCharacteristicValue
    case setNotifyValue
    case discoverDescriptors
    case readDescriptorValue
    case writeDescriptorValue
    case openL2CAPChannel
    // end
    case end
}
