//
//  PKHUD+Rx.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//


import PKHUD
import RxSwift
import RxCocoa

public struct RxHUDValue {
    let type: HUDContentType
    let delay: TimeInterval
    
    init(type: HUDContentType, delay: TimeInterval = 2.0) {
        self.type = type
        self.delay = delay
    }
}


extension HUD {
    public static var rx_loading: UIBindingObserver<PKHUD, Bool> {
        return PKHUD.sharedHUD.rx.loading
    }
    
    public static var rx_flash: UIBindingObserver<PKHUD, RxHUDValue> {
        return PKHUD.sharedHUD.rx.flash
    }
}



extension Reactive where Base: PKHUD {
    
    public var imageFlash: UIBindingObserver<Base, Bool> {
        MainScheduler.ensureExecutingOnScheduler()
        return UIBindingObserver(UIElement: base, binding: { (control, value) in
            if value == true {
                control.contentView = Base.contentView(.rotatingImage(UIImage(named: "alert_waiting_img")))
            } else {
                control.endLoading()
            }
        })
    }
    
    public var flash: UIBindingObserver<Base, RxHUDValue> {
        MainScheduler.ensureExecutingOnScheduler()
        return UIBindingObserver(UIElement: base, binding: { (control, value) in
            control.contentView = Base.contentView(value.type)
            control.show()
            control.hide(afterDelay: value.delay)
        })
    }
    
    public var loading: UIBindingObserver<Base, Bool> {
        MainScheduler.ensureExecutingOnScheduler(errorMessage: "Must on Main scheduler")
        return UIBindingObserver(UIElement: base, binding: { (control, value) in
            value ? control.beginLoading() : control.endLoading()
        })
        
    }
    
    
}

extension PKHUD {
    public func beginLoading() {
        self.contentView = PKHUD.contentView(.progress)
        self.show()
    }
    public func endLoading() {
        self.hide(true)
    }
    
    fileprivate static func contentView(_ content: HUDContentType) -> UIView {
        switch content {
            
        case .success:
            return PKHUDSuccessView()
        case .error:
            return PKHUDErrorView()
        case .progress:
            return PKHUDProgressView()
        case .image(let img):
            return PKHUDSquareBaseView(image: img)
        case .rotatingImage(let img):
            return PKHUDRotatingImageView(image: img)
            
        case let .labeledSuccess(title, subtitle):
            return PKHUDSuccessView(title: title, subtitle: subtitle)
        case let .labeledError(title, subtitle):
            return PKHUDErrorView(title: title, subtitle: subtitle)
        case let .labeledProgress(title, subtitle):
            return PKHUDProgressView(title: title, subtitle: subtitle)
        case let .labeledImage(image, title, subtitle):
            return PKHUDSquareBaseView(image: image, title: title, subtitle: subtitle)
        case let .labeledRotatingImage(image, title, subtitle):
            return PKHUDRotatingImageView(image: image, title: title, subtitle: subtitle)
            
        case .label(let msg):
            return PKHUDTextView(text: msg)
        case .systemActivity:
            return PKHUDSystemActivityIndicatorView()
        }
    }
    /*
     case success
     case error
     case progress
     case image(UIImage?)
     case rotatingImage(UIImage?)
     
     case labeledSuccess(title: String?, subtitle: String?)
     case labeledError(title: String?, subtitle: String?)
     case labeledProgress(title: String?, subtitle: String?)
     case labeledImage(image: UIImage?, title: String?, subtitle: String?)
     case labeledRotatingImage(image: UIImage?, title: String?, subtitle: String?)
     
     case label(String?)
     case systemActivity
     */
}



