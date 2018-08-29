//
//  FlashcardViewController.swift
//  FlashcardApp
//
//  Created by khalil on 8/26/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit
import CoreData

class FlashcardViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var QuestionTextView: UITextView!
    @IBOutlet weak var AnswerTextView: UITextView!
    var ManagedObjectContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting AppDelegate
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        ManagedObjectContext = AppDelegate.persistentContainer.viewContext
        
        //Adding PlaceHolder To textViews
        QuestionTextView.delegate = self
        AnswerTextView.delegate = self
        QuestionTextView.text = "Question Here"
        AnswerTextView.text = "Answer Here"
        QuestionTextView.textColor = UIColor.lightGray
        AnswerTextView.textColor = UIColor.lightGray
        
        //designing border color(other attributes has been added in storyboard)
        let themecolor = UIColor(red: 0.324, green: 0.106, blue: 0.575, alpha: 1)
        AnswerTextView.layer.borderColor = themecolor.cgColor
        QuestionTextView.layer.borderColor = themecolor.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == AnswerTextView {
                textView.text = "Answer Here"
            } else {
                textView.text = "Question Here"
            }
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func SaveCardAction(_ sender: UIButton) {
        guard let question = QuestionTextView.text else {
            print("No Question Entered")
            return
        }
        guard let answer = AnswerTextView.text else {
            print("No answer entered")
            return
        }
        SaveCardToDatabase(Question: question, Answer: answer)
    }
    
    func SaveCardToDatabase(Question: String, Answer: String) {
        let NewFlashcard = NSEntityDescription.insertNewObject(forEntityName: "FlashcardQuiz", into: ManagedObjectContext) as! FlashcardQuiz
        NewFlashcard.answer = Answer
        NewFlashcard.question = Question
        do {
            try ManagedObjectContext.save()
            print("Flashcard saved successfully")
        } catch {
            print("Couldn't save managedObjectContext state. Flashcard not saved")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func CancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
