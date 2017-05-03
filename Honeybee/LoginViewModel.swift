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

extension Result {
    var description: String {
        switch self {
        case .empty:
            return ""
        case let .success(msg):
            return msg
        case let .fail(msg):
            return msg
        }
    }
}


class LoginViewModel {
    
    let username: Driver<Result>
    let loginButtonEnabled: Driver<Bool>
    let loginResult: Driver<Result>
    
    init(input: (username: Driver<String>, password: Driver<String>, loginTap: Driver<Void>), service: ValidationService) {
        
        self.username = input.username
            .flatMapLatest {
            return service
                .validate($0)
                .asDriver(onErrorJustReturn: .fail(msg: "connect service failed"))
        }
        
        let usernameAndPwd = Driver.combineLatest(input.username, input.password) { ($0, $1) }
        
        self.loginResult = input.loginTap
            .withLatestFrom(usernameAndPwd)
            .flatMapLatest {
                return service
                    .login(username: $0.0, password: $0.1)
                    .asDriver(onErrorJustReturn: .fail(msg: "connect service failed"))
        }
        self.loginButtonEnabled = usernameAndPwd
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .asDriver()
//        self.loginButtonEnabled = input.password.map { !$0.isEmpty } .asDriver()
    }
    
}
