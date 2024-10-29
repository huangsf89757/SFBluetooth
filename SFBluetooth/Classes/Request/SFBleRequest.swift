//
//  SFBleRequest.swift
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


// MARK: - SFBleRequest
open class SFBleRequest {
    // MARK: var
    /// 唯一标识
    public private(set) var id = UUID()
    /// 当前执行的cmd
    public private(set) var cmd: SFBleCmd?

    /// 成功回调
    public private(set) var success: SFBleSuccess?
    /// 失败回调
    public private(set) var failure: SFBleFailure?
    /// continuation
    public private(set) var continuation: CheckedContinuation<(data: Any?, msg: String?), Error>?
        
    
    // MARK: func
    open func getStartCmd() -> SFBleCmd? {
        return nil
    }
    open func getNextCmd() -> (Bool, SFBleCmd?) {
        return (false, nil)
    }
    public final func start() {
        doNext()
    }
    private func doNext() {
        let (isSuccess, cmd) = getNextCmd()
        guard isSuccess else {
            // failure
            return
        }
        self.cmd = cmd
        guard let cmd = cmd else {
            // success
            return
        }
        Task {
            do {
                try await cmd.executeAsync()
                doNext()
            } catch let error {
                // failure
            }
        }
    }
}
