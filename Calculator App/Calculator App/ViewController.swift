//
//  ViewController.swift
//  Calculator App
//
//  Created by khalil on 7/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

// Tasks left:
// take input from InputNumber & store it in a variable
// choose some operation and record in some variable
// take the second input
// calculate the result

// if clear pressed clear everything
// error checking



import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var InputNumber: UITextField!
    @IBOutlet weak var OutputLabel: UILabel!
    
    var inputNum1 : Double?
    var inputNum2 : Double?

    enum Operation {
        
        case addition
        case substraction
        case multiplication
        case division
    }
    
    var OperationType : Operation = .addition
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ClearScreenAction(_ sender: UIButton) {
        OutputLabel.text = "Answer: "
        inputNum2 = nil
        inputNum1 = nil
           }
    @IBAction func AddAction(_ sender: UIButton) {
        OperationType = .addition
        StoreNum(Num: &inputNum1)
    }
    @IBAction func SubtractAction(_ sender: UIButton) {
        OperationType = .substraction
        StoreNum(Num: &inputNum1)
    }
    @IBAction func MultiplyAction(_ sender: UIButton) {
        OperationType = .multiplication
        StoreNum(Num: &inputNum1)
    }
    @IBAction func DivideAction(_ sender: UIButton) {
        OperationType = .division
        StoreNum(Num: &inputNum1)
    }
    @IBAction func CalculateAction(_ sender: UIButton) {
        StoreNum(Num: &inputNum2)
        guard let input1 = inputNum1 else {
            OutputLabel.text =  "invalid"
            return
        }
        
        guard let input2 = inputNum2 else {
            OutputLabel.text =  "invalid"
            return
        }
        
        switch OperationType {
        case .addition:
            OutputLabel.text = String(input1 + input2)
        case .substraction:
            OutputLabel.text = String(input1 - input2)
        case .multiplication:
            OutputLabel.text = String(input1 * input2)
        case .division:
            OutputLabel.text = String(input1 / input2)
        }
    }
    
    func StoreNum(Num : inout Double?) {
        guard let firstinput = InputNumber.text else {
            return
        }
        Num = Double(firstinput)
        InputNumber.text?.removeAll()
        }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



