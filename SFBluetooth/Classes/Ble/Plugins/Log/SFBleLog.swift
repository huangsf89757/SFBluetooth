//
//  SFBleLog.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

// MARK: - log
extension Log {
    
    public static func bleTry(id: UUID, tag: String, msgs: [String], result: String? = nil) {
        // id
        let msg_id = "ID: \(id.uuidString)"
        // try
        var msg_try = """
        Try:
            \(tag)
        """
        if msgs.count > 0 {
            msg_try += "\n\(msgs.map { "    \($0)" }.joined(separator: "\n"))"
        }
        // return
        var msg_return = """
        Return:
            \(result)
        """
        // msg
        var msg = msg_id + "\n" + msg_try + "\n" + "\n"
        if result != nil {
            msg += msg_return + "\n"
        }
        msg += "End"
        Log.info("\n\(msg)\n")
    }
    
    public static func bleCallback(id: UUID, tag: String, msgs: [String]) {
        // id
        let msg_id = "ID: \(id.uuidString)"
        // callback
        var msg_callback = """
        Callback:
            \(tag)
        """
        if msgs.count > 0 {
            msg_callback += "\n\(msgs.map { "    \($0)" }.joined(separator: "\n"))"
        }
        // msg
        let msg = msg_id + "\n" + msg_callback + "\n" + "End"
        Log.info("\n\(msg)\n")
    }
    
}
