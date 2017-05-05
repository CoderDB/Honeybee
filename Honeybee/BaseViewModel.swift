//
//  BaseViewModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

enum NavigationEvent {
    case push(UIViewController)
    case pop()
    case present(UIViewController)
    case dismiss()
}

protocol NavigationEventDelegate: class {
    func viewModel(_ viewModel: BaseViewModel, navigationEvent event: NavigationEvent)
}

class BaseViewModel {
    weak var delegate: NavigationEventDelegate?
    
    func push(to vc: UIViewController) {
        delegate?.viewModel(self, navigationEvent: .push(vc))
    }
    func pop() {
        delegate?.viewModel(self, navigationEvent: .pop())
    }
    
    func present(vc: UIViewController) {
        delegate?.viewModel(self, navigationEvent: .present(vc))
    }
    func dismiss() {
        delegate?.viewModel(self, navigationEvent: .dismiss())
    }
}

