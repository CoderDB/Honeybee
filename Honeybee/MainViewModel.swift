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


class MainViewModel {

//    let items: Driver<[RLMRecorder]>
//    let indicatorViewAnimating: Driver<Bool>
//    let loadError: Driver<Error>
//    
//    init() {
//        
//    }
    
    
    let recorder: RLMRecorder
    
    init(recorder: RLMRecorder) {
        self.recorder = recorder
    }
    
}
