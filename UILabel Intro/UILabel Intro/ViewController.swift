//
//  ViewController.swift
//  UILabel Intro
//
//  Created by khalil on 8/25/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Label.backgroundColor = UIColor.lightGray
        
        let newLabel = UILabel(frame: CGRect(x: 10, y: 450, width: 300, height: 100))
        newLabel.backgroundColor = UIColor.brown
        newLabel.numberOfLines = 3
        newLabel.text = "Wish the best of luck"
        newLabel.font = UIFont(name: "Verdana", size: 20)
        newLabel.textColor = UIColor.white
        newLabel.textAlignment = .center
        
        
        self.view.addSubview(newLabel)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

