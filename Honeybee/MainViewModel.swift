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
    let addButtonClicked: PublishSubject<Void> = .init()
    let itemSelected: PublishSubject<RLMRecorder> = .init()
    
    // Out
    let itemSelectedAction: Driver<RecorderrDetailViewModel>
    let section: Driver<[SectionModel<String, RLMRecorder>]>
    let presentAddRecorderViewModel: Observable<AddRecorderViewModel>
    
    init(provider: RxMoyaProvider<ApiProvider>) {
        
        let bag = DisposeBag()
        let deletedItemInput: Variable<RLMRecorder?> = .init(nil)

        
        // In
        section = Observable.combineLatest(viewDidLoad.asObservable(), deletedItemInput.asObservable())
            .map {
                var recorders = Database.default.all(RLMRecorder.self).toArray()
                if let model = $0.1 {
                    if let idx = recorders.index(of: model) {
                        recorders.remove(at: idx)
                    }
                }
                return [SectionModel(model: "", items: recorders)]
            }
            .asDriver(onErrorJustReturn: [])
    
    
        
        // Out
        
        itemSelectedAction =
            itemSelected.map {
                let viewModel = RecorderrDetailViewModel(provider: provider, item: $0)
                viewModel.deletedItemOutput.bind(to: deletedItemInput).disposed(by: bag)
                return viewModel
            }
            .asDriverOnErrorJustComplete()
        
        presentAddRecorderViewModel = addButtonClicked.map {
            AddRecorderViewModel(provider: provider)
        }
    }
    
}
