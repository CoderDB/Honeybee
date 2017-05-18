//
//  MainViewModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 04/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import Moya
import RealmSwift
import RxRealm
import RxDataSources

class MainViewModel: BaseViewModel {
    
    // In
    let viewDidLoad: PublishSubject<Void> = .init()
    let itemSelected: PublishSubject<RLMRecorder> = .init()
    
    // Out
    let itemSelectedAction: Driver<RecorderDetailViewModel>
    let section: Driver<[SectionModel<String, RLMRecorder>]>
    
    init(provider: RxMoyaProvider<ApiProvider>) {
        
        let bag = DisposeBag()
        
        // In
        section = viewDidLoad
            .map {
                let recorders = Database.default.all(RLMRecorder.self).toArray()
                return [SectionModel(model: "", items: recorders)]
            }
            .asDriver(onErrorJustReturn: [])
    
    
        
        // Out
        
        itemSelectedAction =
            itemSelected
            .map {
                RecorderrDetailViewModel(provider: provider, item: $0)
            }.asDriver(onErrorJustReturn: RecorderrDetailViewModel(provider: provider, item: RLMRecorder()))
        
        
    }
    
}
