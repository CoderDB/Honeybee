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

class RecorderrDetailViewModel: NSObject {
    
    let viewDidLoad: PublishSubject<Void> = .init()
    
    init(provider: RxMoyaProvider<ApiProvider>, item: RLMRecorder) {
    
    }
}
