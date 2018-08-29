//
//  ViewController.swift
//  test1project
//
//  Created by khalil on 7/17/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var button: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLabel.backgroundColor = UIColor.brown
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ChangeColor(_ sender: UIButton) {
        TitleLabel.backgroundColor = UIColor.orange
        TitleLabel.text = "Color is now orange!"
        button.text = "surprise!"
        
    }
    
}

