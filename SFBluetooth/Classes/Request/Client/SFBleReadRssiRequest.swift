//
//  SFBleReadRssiRequest.swift
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


// MARK: - SFBleReadRssiRequest
public class SFBleReadRssiRequest: SFBleClientRequest {
    // MARK: var
    public var startScanCmd: SFBleStartScanCmd!
    public var stopScanCmd: SFBleStopScanCmd!
    public var connectPeripheralCmd: SFBleConnectPeripheralCmd!
    public var readRssiCmd: SFBleReadRssiCmd!
    
    // MARK: func
    public override func getStartCmd() -> SFBleCmd {
        if readRssiCmd.check() {
            return readRssiCmd
        }
        else if connectPeripheralCmd.check() {
            return connectPeripheralCmd
        }
        else if stopScanCmd.check() {
            return stopScanCmd
        }
        else {
            return startScanCmd
        }
    }
    
    public override func getNextCmd() -> (Bool, SFBleCmd?) {
        if let cmd = cmd {
            if cmd.id == readRssiCmd.id {
                // end
                return (true, nil)
            }
            else if cmd.id == connectPeripheralCmd.id {
                return (true, readRssiCmd)
            }
            else if cmd.id == stopScanCmd.id {
                return (true, connectPeripheralCmd)
            }
            else if cmd.id == startScanCmd.id {
                return (true, stopScanCmd)
            }
            else {
                // failure
                return (false, nil)
            }
        } else {
            // start
            return (true, getStartCmd())
        }
    }
    
}
