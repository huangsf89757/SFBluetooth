//
//  SFBleStartScanRequest.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/31.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleStartScanRequest
public class SFBleStartScanRequest: SFBleCentralManagerRequest {
    // MARK: var
    private var startScanCmd: SFBleStartScanCmd?
    private var stopScanCmd: SFBleStopScanCmd?
    
    
    public var startScanCmd_services: [CBUUID]?
    public var startScanCmd_options: [String: Any]?
    public var startScanCmd_isForce = false
    public var startScanCmd_condition: ((_ peripheral: CBPeripheral, _ advertisementData: [String : Any], _ RSSI: NSNumber) -> (Bool, Bool))?
    
    public var stopScanCmd_isForce = false
    
    
    public var result_startScanCmd: (CBPeripheral, [String : Any], NSNumber)?
    

    public internal(set) override var result: (Any?, String?, Bool)? {
        didSet {
            guard let cmd = cmd else { return }
            if cmd.id == getStartScanCmd().id {
                result_startScanCmd = result as? (CBPeripheral, [String : Any], NSNumber)
            }
        }
    }
    
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager) {
        super.init(name: "startScan", bleCentralManager: bleCentralManager)
    }
    
    
    // MARK: func
    public override func getStartCmd() -> SFBleCmd? {
        let stopScanCmd = getStopScanCmd()
        if let (peripheral, advertisementData, RSSI) = result_startScanCmd,
           let (isMatch, isContinue) = startScanCmd_condition?(peripheral, advertisementData, RSSI),
           stopScanCmd.check() {
            return stopScanCmd
        }
        else {
            return getStartScanCmd()
        }
    }
    
    public override func getNextCmd() -> (Bool, SFBleCmd?) {
        if let cmd = cmd {
            if cmd.id == getStartScanCmd().id {
                return (true, getStopScanCmd())
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
    
    // MARK: cmd
    private func getStartScanCmd() -> SFBleStartScanCmd {
        if let startScanCmd = startScanCmd {
            return startScanCmd
        }
        let cmd = SFBleStartScanCmd(bleCentralManager: bleCentralManager)
        cmd.services = startScanCmd_services
        cmd.options = startScanCmd_options
        cmd.isForce = startScanCmd_isForce
        cmd.condition = startScanCmd_condition
        return cmd
    }
    
    private func getStopScanCmd() -> SFBleStopScanCmd {
        if let stopScanCmd = stopScanCmd {
            return stopScanCmd
        }
        let cmd = SFBleStopScanCmd(bleCentralManager: bleCentralManager)
        cmd.isForce = stopScanCmd_isForce
        return cmd
    }
}
