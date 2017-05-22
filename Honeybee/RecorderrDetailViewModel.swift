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
import RxDataSources
import RxSwiftUtilities

class RecorderrDetailViewModel: NSObject {
    
    // In
    let viewDidLoad: PublishSubject<Void> = .init()
    
    // Out
    let navigationBarTitle: Driver<String>
    let headerInfo: Driver<(title: String, imgName: String, color: String)>
    let section: Observable<[SectionModel<String, RLMRecorder>]>
    let loadingIsActive: Driver<Bool>
    
    init(provider: RxMoyaProvider<ApiProvider>, item: RLMRecorder) {
    
        // Out
        navigationBarTitle = .just("详情")
        
        headerInfo = Observable
            .just(item)
            .map { ($0.category, $0.imageName, $0.color) }
            .asDriver(onErrorJustReturn: ("", "", ""))
        
        section = Observable
            .just([
                SectionModel.init(model: "", items: [item]),
                SectionModel.init(model: "", items: [item]),
                SectionModel.init(model: "", items: [item]),
                SectionModel.init(model: "", items: [item])
            ])
        
        let activityIndicator = ActivityIndicator()
        loadingIsActive = activityIndicator.asDriver()
        
        
    }
}
