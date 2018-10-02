//
//  Action.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 17..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

public class Action<T> {
    public var onDone:(T) -> Void = {(result: T) -> Void in}
    public var onCancel:() -> Void = {() -> Void in}
    public var onError:(Fail) -> Void = {(fail: Fail) -> Void in}
    
    public var go:() -> Void = {() -> Void in}
}


@objc protocol ActionL {
    func onDone(message:String) -> Void
    func onCancel() -> Void
    func onError(fail:Fail) -> Void
}
//public class Action<T> {
//    var onDone:(T) -> Void = {(result: T) -> Void in}
//    var onCancel:() -> Void = {() -> Void in}
//    var onError:(Fail) -> Void = {(fail: Fail) -> Void in}
//    
//    var go:() -> Void = {() -> Void in}
//    
//    init(onDone: @escaping (T) -> Void, onCancel: @escaping () -> Void, onError: @escaping (Fail) -> Void) {
//        self.onDone = onDone
//        self.onCancel = onCancel
//        self.onError = onError
//    }
//}
