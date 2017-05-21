//
//  ValidationService.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ValidationService {
    static let `default` = ValidationService()
    private init() {}
    
    let minCharactersCount = 6
    
    func validate(_ text: String) -> Observable<Result> {
        if text.isEmpty {
            return .just(.empty)
        }
//        guard !text.isEmpty else {
//            return .just(.empty)
//        }
        if text.characters.count < minCharactersCount {
            return .just(.fail(msg: "The characters should be 6 at least"))
        }
        return .just(.success(msg: "Success"))
    }
    
    //    func validate(password: String) -> Observable<Result> {
    //        guard !password.isEmpty else {
    //            return .just(.empty)
    //        }
    //        if password.characters.count < minCharactersCount {
    //            return .just(.fail(msg: ""))
    //        }
    //        return .just(.success(msg: ""))
    //    }
    
    
    func login(username: String, password: String) -> Observable<Result> {
        if username == "dongbing", password == "123456" {
            return .just(.success(msg: "Login Succeed"))
        }
        return .just(.fail(msg: "Username or Password is not true"))
    }
    
}

