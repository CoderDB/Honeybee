//
//  HBPresentationController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class HBPresentationController: UIPresentationController {
    
    let cornerRadius: CGFloat = 15
    var presentationWrappingView: UIView!
    var dimmingView: UIView!
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedViewController.modalPresentationStyle = .custom
    }
    
    override var presentedView : UIView? {
        return presentationWrappingView
    }
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let presentedViewContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: bounds.size)
        return CGRect(x: bounds.origin.x, y: bounds.maxY - presentedViewContentSize.height, width: bounds.size.width, height: presentedViewContentSize.height)
    }
}


// MARK: Layout
extension HBPresentationController {
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if let container = container as? UIViewController, container == presentedViewController {
            containerView?.setNeedsLayout()
        }
    }
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if let container = container as? UIViewController, container == presentedViewController{
            return container.preferredContentSize
        }
        return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        dimmingView?.frame = containerView!.bounds
        presentationWrappingView?.frame = frameOfPresentedViewInContainerView
    }
}

// MARK: presentationTransitionWillBegin/End
extension HBPresentationController {
    
    override func presentationTransitionWillBegin() {
        let shadowView = UIView(frame: frameOfPresentedViewInContainerView)
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 15
        shadowView.layer.shadowOffset = CGSize(width: 0, height: -6)
        presentationWrappingView = shadowView
        
        let masks: UIViewAutoresizing = [.flexibleWidth, .flexibleHeight]
        let roundCornerView = UIView(frame: UIEdgeInsetsInsetRect(shadowView.bounds, UIEdgeInsetsMake(0, 0, -cornerRadius, 0)))
        roundCornerView.autoresizingMask = masks
        roundCornerView.layer.cornerRadius = cornerRadius
        roundCornerView.layer.masksToBounds = true
        
        let presentedViewControllerWrapperView = UIView(frame: UIEdgeInsetsInsetRect(roundCornerView.bounds, UIEdgeInsetsMake(0, 0, cornerRadius, 0)))
        presentedViewControllerWrapperView.autoresizingMask = masks
        
        let presentedViewControllerView = super.presentedView
        presentedViewControllerView?.autoresizingMask = masks
        presentedViewControllerView?.frame = presentedViewControllerWrapperView.bounds
        
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView!)
        roundCornerView.addSubview(presentedViewControllerWrapperView)
        shadowView.addSubview(roundCornerView)
        
        dimmingView = UIView(frame: (containerView?.bounds)!)
        dimmingView.backgroundColor = .black
        dimmingView.isOpaque = false
        dimmingView.autoresizingMask = masks
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnDimmingView(_:))))
        containerView?.addSubview(dimmingView)
        
        let coordinator = presentingViewController.transitionCoordinator
        self.dimmingView.alpha = 0
        coordinator?.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.8
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            presentationWrappingView = nil
            dimmingView = nil
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let coordinator = presentingViewController.transitionCoordinator
        coordinator?.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            presentationWrappingView = nil
            dimmingView = nil
        }
    }
}

// MARK: UI Event
extension HBPresentationController {
    func tapOnDimmingView(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}


// MARK: UIViewControllerTransitioningDelegate
extension HBPresentationController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HBPresentationAnimator()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HBPresentationAnimator()
    }
}
