//
//  SFBle.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/18.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

// MARK: - SFBle
public class SFBle: NSObject {
    public var id: String?
}

// MARK: - log
extension SFBle {
    
    public func logTry(tag: String, msgs: [String], result: String? = nil) {
        // id
        let msg_id = "ID: \(id ?? "nil")"
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
    
    public func logCallback(tag: String, msgs: [String]) {
        // id
        let msg_id = "ID: \(id ?? "nil")"
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
