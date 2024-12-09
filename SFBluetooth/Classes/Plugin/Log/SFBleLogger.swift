//
//  SFBleLogger.swift
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

// MARK: - SFBleLogger
public class SFBleLogger {
    public static func tryDo(file: String = #file, function: String = #function, line: Int = #line, context: Any? = nil,
                             tag: String, msgs: [String], result: String? = nil) {
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
        var msg = msg_try + "\n" + "\n"
        if result != nil {
            msg += msg_return + "\n"
        }
        msg += "End"
        SFLogger.info(file: file, function: function, line: line, context: context, msgs: "\n\(msg)\n")
    }
    
    public static func callback(file: String = #file, function: String = #function, line: Int = #line, context: Any? = nil,
                                tag: String, msgs: [String]) {
        // callback
        var msg_callback = """
        Callback:
            \(tag)
        """
        if msgs.count > 0 {
            msg_callback += "\n\(msgs.map { "    \($0)" }.joined(separator: "\n"))"
        }
        // msg
        let msg = msg_callback + "\n" + "End"
        SFLogger.info(file: file, function: function, line: line, context: context, msgs: "\n\(msg)\n")
    }
    
    public static func summary(file: String = #file, function: String = #function, line: Int = #line, context: Any? = nil,
                               tag: String, msgs: [String]) {
        // callback
        var msg_callback = """
        Summary:
            \(tag)
        """
        if msgs.count > 0 {
            msg_callback += "\n\(msgs.map { "    \($0)" }.joined(separator: "\n"))"
        }
        // msg
        let msg = msg_callback + "\n" + "End"
        SFLogger.info(file: file, function: function, line: line, context: context, msgs: "\n\(msg)\n")
    }
}
