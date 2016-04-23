//
//  ViewController.swift
//  ExpandingAnimation
//
//  Created by Kamil Makowski on 19/03/16.
//  Copyright © 2016 Kamil Makowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleButtonAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewControllerWithIdentifier("SecondViewControllerID") as! SecondViewController;
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if(operation == .Push) {
            return TransitionAnimator()
        }
        return nil
    }


}

