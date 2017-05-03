//
//  LoginViewModel.swift
//  Honeybee
//
//  Created by admin on 03/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


enum Result {
    case success(msg: String)
    case fail(msg: String)
    case empty
}


class ValidationService {
    static let `default` = ValidationService()
    private init() {}
    
    let minCharactersCount = 6
    
    func validate(_ text: String) -> Observable<Result> {
        guard !text.isEmpty else {
            return .just(.empty)
        }
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
        if password == "123456" {
            return .just(.success(msg: "Login Succeed"))
        }
        return .just(.fail(msg: "Login Failed"))
    }
    
}



class LoginViewModel {
    
    let username: Driver<Result>
    let loginButtonEnabled: Driver<Bool>
    let loginResult: Driver<Result>
    
    init(input: (username: Driver<String>, password: Driver<String>, loginTaps: Driver<Void>), service: ValidationService) {
        
        self.username = input.username
            .flatMapLatest {
            return service
                .validate($0)
                .asDriver(onErrorJustReturn: .fail(msg: "connect service failed"))
        }
        
        let usernameAndPwd = Driver.combineLatest(input.username, input.password) { ($0, $1) }
        
        self.loginResult = input.loginTaps.withLatestFrom(usernameAndPwd).flatMapLatest {
            return service
                .login(username: $0.0, password: $0.1)
                .asDriver(onErrorJustReturn: .fail(msg: "connect service failed"))
        }
        
        self.loginButtonEnabled = input.password.map { !$0.isEmpty } .asDriver()
        
        
    }
    
}
