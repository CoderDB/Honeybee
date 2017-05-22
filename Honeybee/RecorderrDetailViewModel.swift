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
    let deleteAction: PublishSubject<Void> = .init()
    
    // Out
    let navigationBarTitle: Driver<String>
    let headerInfo: Driver<(title: String, imgName: String, color: String)>
    let section: Observable<[SectionModel<String, RLMRecorder>]>
    let loadingIsActive: Driver<Bool>
    let showSuccess: Driver<RxHUDValue>
    let popViewController: Observable<Void>
    
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
        let successHUD = RxHUDValue(type: .label("删除成功"))
        let failHUD = RxHUDValue(type: .label("删除失败"))
        loadingIsActive = activityIndicator.asDriver()
        
        showSuccess = deleteAction
            .map {
                try Database.default.delete(item: item)
            }
            .trackActivity(activityIndicator)
            .catchError { _ in return }
            .shareReplay(1)
            .map { _ in successHUD }
            .asDriver(onErrorJustReturn: failHUD)
        
        
        popViewController = showSuccess.asObservable().mapToVoid()
    }
}
