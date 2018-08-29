//
//  ViewController.swift
//  UIButtons Intro
//
//  Created by khalil on 8/26/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ButtonOutlet: UIButton!
    @IBOutlet weak var Label: UILabel!
    var newlabel : UILabel!
    var newButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newlabel = UILabel(frame: CGRect(x: 20, y: 450, width: 280, height: 50))
        newlabel.backgroundColor = UIColor.orange
        newlabel.text = "Here is a new label"
        newlabel.textAlignment = .center
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ButtonAction(_ sender: UIButton) {
       /* if !self.view.contains(newlabel) {
            self.view.addSubview(newlabel)
        }*/
        Label.text = sender.currentTitle
        if self.view.backgroundColor == UIColor.black {
            self.view.backgroundColor = UIColor.white
            Label.textColor = UIColor.black
        } else {
            self.view.backgroundColor = UIColor.black
            Label.textColor = UIColor.white
        }
    }
    @IBAction func PressAction2(_ sender: UIButton) {
    }
    @IBAction func PressAction3(_ sender: UIButton) {
        newButton = UIButton(frame: CGRect(x: 20, y: 300, width: 280, height: 50))
        newButton.addTarget(self, action: #selector(PressButton), for: .touchUpInside)
        newButton.backgroundColor = UIColor.green
        newButton.setTitle("Suprise! Press Me!!!", for: .normal)
        if !self.view.subviews.contains(newButton) {
            self.view.addSubview(newButton)
        }
        
    }
    
    @objc func PressButton(_ sender: UIButton) {
        if !self.view.contains(newlabel) {
            self.view.addSubview(newlabel)
        }
    }
    
}

