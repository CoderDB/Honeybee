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


class RecorderrDetailController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
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
        configUI()
    }
    deinit {
        print("RecorderrDetailController---deinit")
    }
    private func configUI() {
        tableView.estimatedRowHeight = HB.Constant.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset.bottom = 100
        let header = RecordDetailHeader(height: 115, title: "", imageName: "meal", color: "")
        tableView.tableHeaderView = header
        tableView.tableFooterView = RecordDetailFooter(height: 50)
        tableView.register(RecordDetailCell.self)
    }
    
    private func configRx(viewModel: RecorderrDetailViewModel) {
        
        // In
        viewModel.navigationBarTitle.drive(self.rx.title).disposed(by: disposeBag)
        
        
    }
}
