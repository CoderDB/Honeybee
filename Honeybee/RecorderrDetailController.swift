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
import PKHUD


class RecorderrDetailController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let rx_dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RLMRecorder>>()
    
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
        tableView.tableFooterView = RecordDetailFooter(height: 50)
        tableView.register(RecordDetailCell.self)
    }
    
    private func configRx(viewModel: RecorderrDetailViewModel) {
        rx_dataSource.configureCell = { ds, tv, idx, item in
            let cell = tv.dequeueCell(RecordDetailCell.self, for: idx)
            cell.config(at: idx, model: item)
            return cell
        }
        
        // In
        viewModel.navigationBarTitle
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.loadingIsActive.drive(HUD.rx_loading).disposed(by: disposeBag)
        
        viewModel.headerInfo.asObservable()
            .subscribe(onNext: { [unowned self] (data) in
                let header = RecordDetailHeader(height: 115, title: data.title, imageName: data.imgName, color: data.color)
                self.tableView.tableHeaderView = header
        })
        .disposed(by: disposeBag)
        
        viewModel
            .section
            .bind(to: tableView.rx.items(dataSource: rx_dataSource))
            .disposed(by: disposeBag)
        
        viewModel.showSuccess.drive(HUD.rx_flash).disposed(by: disposeBag)
        
        viewModel.popViewController
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
    }
}
