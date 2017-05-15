//
//  MainViewModel.swift
//  Honeybee
//
//  Created by admin on 04/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import Moya

class MainViewModel: BaseViewModel {
    
    let viewDidLoad: PublishSubject<Void> = .init()
    
    init(provider: RxMoyaProvider<ApiProvider>) {
        
    }
    
}
