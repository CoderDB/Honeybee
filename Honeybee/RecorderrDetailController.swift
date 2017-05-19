//
//  RecorderrDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 20/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift


class RecorderrDetailController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    convenience init(viewModel: RecorderrDetailViewModel) {
        self.init(nibName: "RecorderrDetailController", bundle: Bundle.main)
        self.rx
            .viewDidLoad
            .subscribe(onNext: { [weak self] _ in
                self?.configRx(viewModel: viewModel)
            })
            .disposed(by: disposeBag)
        
        self.rx
            .viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }


    func configRx(viewModel: RecorderrDetailViewModel) {
        
    }
}
