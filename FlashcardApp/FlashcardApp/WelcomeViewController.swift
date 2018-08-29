//
//  WelcomeViewController.swift
//  FlashcardApp
//
//  Created by khalil on 8/27/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var StartLabel: UIButton!
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! ViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = StartLabel.center
        transition.circleColor = StartLabel.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = StartLabel.center
        transition.circleColor = StartLabel.backgroundColor!
        
        return transition
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func StartButton(_ sender: UIButton) {
    }
}
