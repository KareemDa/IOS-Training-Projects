//
//  CircularTransition.swift
//  FlashcardApp
//
//  Created by khalil on 8/27/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    var circle = UIView()
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    var duration = 0.3
    enum CircularTransitionMode:Int {
        case present,dismiss,pop
    }
    var transitionMode : CircularTransitionMode = .present
}

extension CircularTransition:UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewsSize = presentedView.frame.size
                
                circle = UIView()
                circle.frame  = FrameForCircle(withViewCenter: viewCenter, size: viewsSize, startpoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                containerView.addSubview(circle)
                
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: {(Success:Bool) in
                    transitionContext.completeTransition(Success)
                })
            }
        } else {
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = FrameForCircle(withViewCenter: viewCenter, size: viewSize, startpoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                    
                }, completion: {(success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
            
        }
    }
}

func FrameForCircle(withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startpoint:CGPoint) -> CGRect {
    let xlength = fmax(startpoint.x, viewSize.width - startpoint.x)
    let ylength = fmax(startpoint.y,viewSize.height - startpoint.y)
    
    let offsetVector = sqrt(xlength * xlength + ylength * ylength) * 2
    let size = CGSize(width: offsetVector, height: offsetVector)
    return CGRect(origin: CGPoint.zero, size: size)
    }
