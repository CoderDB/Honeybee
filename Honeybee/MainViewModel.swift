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


class MainViewModel: BaseViewModel {

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

//extension MainViewModel: DataProvider {
//    typealias ItemType = RLMRecorder
//    typealias AnotherItemType = RLMRecorder
//    func numberOfSections() -> Int {
//        return 1
//    }
//    func numberOfItems(in section: Int) -> Int {
//        return
//    }
//
//}
