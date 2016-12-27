//
//  HBPresentationAnimator.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class HBPresentationAnimator: NSObject {

}

// MARK: UIViewControllerAnimatedTransitioning
extension HBPresentationAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let isAnimated = transitionContext?.isAnimated else {
            return 0
        }
        return isAnimated ? 0.35 : 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromVC!)
        var toViewInitialFrame = transitionContext.initialFrame(for: toVC!)
        let toViewFinalFrame = transitionContext.finalFrame(for: toVC!)
        
        if toView != nil {
            containerView.addSubview(toView!)
        }
        
        let isPresenting = (toVC?.presentingViewController == fromVC)
        if isPresenting {
            toViewInitialFrame = CGRect(origin: CGPoint(x: containerView.bounds.minX, y: containerView.bounds.maxY), size: toViewFinalFrame.size)
            toView?.frame = toViewInitialFrame
        } else {
            fromViewFinalFrame = fromView!.frame.offsetBy(dx: 0, dy: fromView!.frame.height)
        }
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            if isPresenting {
                toView?.frame = toViewFinalFrame
            } else {
                fromView?.frame = fromViewFinalFrame
            }
        }, completion: { (_) in
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
        })
    }
}
