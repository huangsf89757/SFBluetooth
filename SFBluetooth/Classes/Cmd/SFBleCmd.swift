//
//  SFBleCmd.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/10/18.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleResponse
public typealias SFBleSuccess = (_ data: Any?, _ msg: String?) -> Void
public typealias SFBleFailure = (_ error: SFBleError) -> Void


// MARK: - SFBleCmd
public class SFBleCmd {
    // MARK: var
    /// 类型
    public var type: SFBleCmdType
    /// 唯一标识
    public private(set) var id = UUID()
    /// 进程
    public private(set) var process: SFBleProcess = .none
    /// 插件
    public var plugins: [SFBleCmdPlugin] = [SFBleCmdLogPlugin()]
    /// 成功回调
    public private(set) var success: SFBleSuccess
    /// 失败回调
    public private(set) var failure: SFBleFailure
    
    
    // MARK: life cycle
    public init(type: SFBleCmdType, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.type = type
        
        self.success = success
        self.failure = failure
    }
    
    // MARK: func
    open func excute() {
        self.id = UUID()
    }
}

// TODO: 使用async/await改进代码，避免无限嵌套
/*
 let cmd1 = SFBleCmd(type: .client("cmd1")) { data, msg in
     let cmd2 = SFBleCmd(type: .client("cmd2")) { data, msg in
         let cmd3 = SFBleCmd(type: .client("cmd3")) { data, msg in
             let cmd4 = SFBleCmd(type: .client("cmd4")) { data, msg in
                 print("cmd4 success")
             } failure: { error in
                 print("cmd4 failure")
             }
             cmd4.excute()
         } failure: { error in
             print("cmd3 failure")
         }
         cmd3.excute()
     } failure: { error in
         print("cmd2 failure")
     }
     cmd2.excute()
 } failure: { error in
     print("cmd1 failure")
 }
 cmd1.excute()
 */

// MARK: - SFBleProcess
public enum SFBleProcess {
    case none
    case start
    case waiting
    case doing
    case end
}
extension SFBleCmd {
    public func onStart(msg: String? = nil) {
        self.process = .start
        plugins.forEach { plugin in
            plugin.onStart(type: type, msg: msg)
        }
    }
    public func onWaiting(msg: String? = nil) {
        self.process = .waiting
        plugins.forEach { plugin in
            plugin.onWaiting(type: type, msg: msg)
        }
    }
    public func onDoing(msg: String? = nil) {
        self.process = .doing
        plugins.forEach { plugin in
            plugin.onDoing(type: type, msg: msg)
        }
    }
    public func onSuccess(data: Any?, msg: String? = nil) {
        self.process = .end
        plugins.forEach { plugin in
            plugin.onSuccess(type: type, data: data, msg: msg)
        }
        success(data, msg)
    }
    public func onFailure(error: SFBleError) {
        self.process = .end
        plugins.forEach { plugin in
            plugin.onFailure(type: type, error: error)
        }
        failure(error)
    }
}
