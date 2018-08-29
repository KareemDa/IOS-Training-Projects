//
//  ViewController.swift
//  Alert Controller
//
//  Created by khalil on 8/16/18.
//  Copyright © 2018 Ejad. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var CreateAccountOutlet: UIButton!
    @IBOutlet weak var LoginOutlet: UIButton!
    @IBOutlet weak var Label_1: UILabel!
    @IBOutlet weak var Label_2: UILabel!
    var AlertController = UIAlertController()
    var Users : [(String, String)]  = [("Kareem","Secret123") , ("Dani","Secret1234")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        @IBAction func Button_2(_ sender: UIButton) {
        let CreateAccountWidth = CreateAccountOutlet.frame.width
        let CreateAccountHeight = CreateAccountOutlet.frame.height
        let CreateAccountY = CreateAccountOutlet.frame.minY
        let CreateAccountX = CreateAccountOutlet.frame.minX
            
        let LoginWidth = LoginOutlet.frame.width
        let LoginHeight = LoginOutlet.frame.height
        let LoginY = LoginOutlet.frame.minY
        let LoginX = LoginOutlet.frame.minX
    
            func resetButtons() -> Void {
                
                self.CreateAccountOutlet.frame = CGRect(x: CreateAccountX, y: CreateAccountY, width: CreateAccountWidth, height: CreateAccountHeight)
                self.LoginOutlet.frame = CGRect(x: LoginX, y: LoginY, width: LoginWidth, height: LoginHeight)
                self.CreateAccountOutlet.transform = CGAffineTransform(
                return
            }
            
        CreateAccountOutlet.frame = CGRect(x: CreateAccountX, y: CreateAccountY - 20, width: CreateAccountWidth, height: CreateAccountHeight)
        self.LoginOutlet.frame = CGRect(x: LoginX, y: LoginY + 125, width: LoginWidth, height: LoginHeight)
        AlertController = UIAlertController(title: "Create Account In Tawassy", message: "Please enter your username and password", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: {(ACTION: UIAlertAction) -> Void in print("Login has been canceled")})
        
        let createAccountAction = UIAlertAction(title: "Create Account", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            guard let textFields = self.AlertController.textFields else {
                resetButtons()
                return
            }
            guard let username = textFields[0].text else  {
                print("No username entered");
                resetButtons()
                return
            }
            guard let password = textFields[1].text else {
                print("No password entered");
                resetButtons()
                return
            }
            guard let confirm = textFields[2].text else {
                print("No password-confirm entered");
                resetButtons()
                return
            }
            
            for i in 0..<self.Users.count {
                if self.Users[i].0 == username {
                    self.Label_1.text = "this username already has an account"
                    resetButtons()
                    return
                }
            }
            
            
            if password.count == 0 || confirm != password {
                self.Label_1.text = "Passwords don't match"
                self.AlertController.dismiss(animated: true, completion: {() -> Void in})
                resetButtons()
                return
            }
        
            self.Users.append((username,password))
            self.Label_1.text = "Your account has been created successfully"
           resetButtons()
            
            
        })
        
        AlertController.addAction(cancelAction)
        AlertController.addAction(createAccountAction)
        AlertController.preferredAction = createAccountAction
        
        AlertController.addTextField(configurationHandler: {(TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "username"
            TEXTFIELD.autocapitalizationType = .words
        })
        AlertController.addTextField(configurationHandler: {(TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "password"
            TEXTFIELD.isSecureTextEntry = true
        })
        AlertController.addTextField(configurationHandler: {(TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "confirm password"
            TEXTFIELD.isSecureTextEntry = true
        })
        
        present(AlertController, animated: true, completion: {() -> Void in print("user is trying to login")})
        
        
        
       
    }
    
    
    @IBAction func Button_3(_ sender: UIButton) {
        AlertController = UIAlertController(title: "Login to Tawassy", message: "Please enter your username and password", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: {(ACTION: UIAlertAction) -> Void in print("Login has been canceled")})
        
        let loginAction = UIAlertAction(title: "Login", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            guard let textFields = self.AlertController.textFields else {
                return
            }
            guard let username = textFields[0].text else  {
                print("No username entered");return
            }
            guard let password = textFields[1].text else {
                print("No password entered");return
            }
            var Invalid : Bool = true
            for i in 0..<self.Users.count {
                if self.Users[i].0 == username && self.Users[i].1 == password {
                    print("login successful")
                    Invalid = false
                    self.Label_1.text = "Welcome \(username)!"
                    self.Label_2.text = "Your current password is: \(password)"
                }
            }
            if Invalid {
                print("invalid username or password")
                self.AlertController.message = "Invalid Username of password"
                self.Label_1.text = "invalid username or password"
                self.Label_2.text = ""
            }
            
            
        })
        
        AlertController.addAction(cancelAction)
        AlertController.addAction(loginAction)
        AlertController.preferredAction = loginAction
        
        AlertController.addTextField(configurationHandler: {(TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "username"
            TEXTFIELD.autocapitalizationType = .words
        })
        AlertController.addTextField(configurationHandler: {(TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "password"
            TEXTFIELD.isSecureTextEntry = true
        })
        
        present(AlertController, animated: true, completion: {() -> Void in print("user is trying to login")})
        
    }
    
    @IBAction func Button_4(_ sender: UIButton) {
        AlertController = UIAlertController(title: "Alert with action", message: "This is an alert with dismiss action", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "dismiss", style: .cancel, handler: {(ACTION: UIAlertAction) -> Void in print("Alert with dismiss is bieng dismissed")})
        let blueAction = UIAlertAction(title: "Blue", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            self.view.backgroundColor = UIColor.blue
        })
        let cyanAction = UIAlertAction(title: "cyan", style: .default, handler: {(ACTION: UIAlertAction) -> Void in
            self.view.backgroundColor = UIColor.cyan
        })
        AlertController.addAction(cancelAction)
        AlertController.addAction(blueAction)
        AlertController.addAction(cyanAction)
        present(AlertController, animated: true, completion: {() -> Void in print("Alert with dismiss is bieng displayed")})
    }
    

}

