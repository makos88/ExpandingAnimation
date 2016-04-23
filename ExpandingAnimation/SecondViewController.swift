//
//  SecondViewController.swift
//  ExpandingAnimation
//
//  Created by Kamil Makowski on 19/03/16.
//  Copyright © 2016 Kamil Makowski. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var button: UIButton!
    
    var percentTransition: UIPercentDrivenInteractiveTransition?
    
    @IBAction func handleBackAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()        
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("panned:"))
        panGesture.edges = .Left;
        self.view.addGestureRecognizer(panGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.delegate = self
    }
    
    func panned(gestureRecognizer: UIPanGestureRecognizer) {
        var per = (gestureRecognizer.translationInView(self.view).x / CGRectGetWidth(self.view.bounds)) as CGFloat
        per = min(1.0,(max(0.0, per)));
        print(per);
        if (gestureRecognizer.state == .Began) {
            self.percentTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        } else if (gestureRecognizer.state == .Changed) {
            self.percentTransition?.updateInteractiveTransition(per)
        } else if (gestureRecognizer.state == .Ended || gestureRecognizer.state == .Cancelled) {
            if (per > 0.3) {
                self.percentTransition?.finishInteractiveTransition()
            } else {
                self.percentTransition?.cancelInteractiveTransition()
            }
            self.percentTransition = nil
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.percentTransition
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == .Pop) {
            return TransitionInvertAnimator()
        }
        return nil
    }    
}
