//
//  AddRecorderViewModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class AddRecorderViewModel {
    
    
    let viewDidLoad: PublishSubject<Void> = .init()
    
    init(provider: RxMoyaProvider<ApiProvider>) {
        
        
    }
    
    deinit {
        print("AddRecorderViewModel ----deinit")
    }
}
