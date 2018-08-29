//
//  ViewController.swift
//  Hangman Game
//
//  Created by khalil on 7/29/18.
//  Copyright © 2018 Ejad. All rights reserved.
//
//create arrays to hold the word an hint

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var HintLabel: UILabel!
    @IBOutlet weak var GuessLabel: UILabel!
    @IBOutlet weak var RemGuessesLabel: UILabel!
    @IBOutlet weak var InputTextField: UITextField!
    @IBOutlet weak var LetterBankLabel: UILabel!
    
    let LIST_OF_WORDS : [String] = ["hello","goodbye","ejad","coffee","hangman"]
    let LIST_OF_HINTS : [String] = ["greeting","farewell","company here","a good way to wake up","letter guessing name"]
    var WordToGuess : String!
    let MAX_NUMBER_OF_GUESSES : Int = 5
    var GuessesRemaining : Int!
    var WordAsUnderscore : String = ""
    var LastRandomNumber : Int = -1;
    override func viewDidLoad() {
        super.viewDidLoad()
        InputTextField.delegate = self
        InputTextField.becomeFirstResponder()
        InputTextField.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func NewWordAction(_ sender: UIButton) {
        reset()
        let Index : Int = RandomNumber()
        WordToGuess = LIST_OF_WORDS[Index]
        for _ in 1...WordToGuess.count {
            WordAsUnderscore.append("_")
        }
        GuessLabel.text = WordAsUnderscore
        let hint = LIST_OF_HINTS[Index]
        HintLabel.text = "Hint: \(hint), \(WordToGuess.count) number of letters"
        
        
        
    }
    func reset() {
        GuessesRemaining = MAX_NUMBER_OF_GUESSES
        RemGuessesLabel.text = "\(GuessesRemaining!) guesses remaining"
        WordAsUnderscore = ""
        InputTextField.isEnabled = true
        InputTextField.text?.removeAll()
        LetterBankLabel.text? = ""
    }
    func RandomNumber() -> Int {
        var x : Int = Int(arc4random_uniform(UInt32(LIST_OF_WORDS.count)))
        if x == LastRandomNumber {
            x = RandomNumber()
        }
        LastRandomNumber  = x
        return x
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let LetterGuessed : String = textField.text else { return }
        InputTextField.text?.removeAll()
        if WordToGuess == nil { return }
        let CurrentLetterBank : String = LetterBankLabel.text ?? ""
        if CurrentLetterBank.contains(LetterGuessed) { return }
        if WordToGuess.contains(LetterGuessed) {
            ProcessCorrectGuess(LetterGuessed: LetterGuessed)
        } else {
            ProcessIncorrectGuess(LetterGuessed: LetterGuessed)
        }
        LetterBankLabel.text?.append("\(LetterGuessed), ")
    }
    
    func ProcessCorrectGuess(LetterGuessed : String) {
        for index in WordToGuess.indices {
            if WordToGuess[index] == Character(LetterGuessed) {
                let EndIndex = WordToGuess.index(after: index)
                let CharRange = index ..< EndIndex
                WordAsUnderscore = WordAsUnderscore.replacingCharacters(in: CharRange, with: LetterGuessed)
            }
        }
        GuessLabel.text = WordAsUnderscore
        if !(WordAsUnderscore.contains("_")) {
            RemGuessesLabel.text = "You Win! :D"
            InputTextField.isEnabled = false
        }
    }
    func ProcessIncorrectGuess(LetterGuessed : String) {
        GuessesRemaining! -= 1
        if GuessesRemaining == 0 {
            InputTextField.isEnabled = false
            RemGuessesLabel.text = "You Lost! :("
            
        } else {
            RemGuessesLabel.text = "\(GuessesRemaining!) guesses remaining"
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        InputTextField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let AllowedCharacters = NSCharacterSet.lowercaseLetters
        let StartingLength = textField.text?.count ?? 0
        let LengthToAdd = string.count
        let LengthToReplace = range.length
        let NewLegth = StartingLength + LengthToAdd - LengthToReplace
        if string.isEmpty {
            return true
        }
        else if NewLegth == 1 {
            if let _ = string.rangeOfCharacter(from: AllowedCharacters, options: .caseInsensitive) {
                return true
            }
        }
        return false
    }
    
}

