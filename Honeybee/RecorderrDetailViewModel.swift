//
//  RecorderrDetailViewModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 20/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class RecorderrDetailViewModel: NSObject {
    
    // In
    let viewDidLoad: PublishSubject<Void> = .init()
    
    // Out
    let navigationBarTitle: Driver<String>
    
    init(provider: RxMoyaProvider<ApiProvider>, item: RLMRecorder) {
    
        // Out
        navigationBarTitle = .just("详情")
    }
}
