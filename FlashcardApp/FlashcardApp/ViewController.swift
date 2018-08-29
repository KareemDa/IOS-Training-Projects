//
//  ViewController.swift
//  FlashcardApp
//
//  Created by khalil on 8/26/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var AnswerView: UIView!
    @IBOutlet weak var QuestionView: UIView!
    @IBOutlet weak var ContainerQAView: UIView!
    @IBOutlet weak var CardContentAnswerLabel: UILabel!
    @IBOutlet weak var CardContentQuestionLabel: UILabel!
    var ManagedObjectContext : NSManagedObjectContext!
    var ListOfCards = [FlashcardQuiz]()
    var CurrentCard : FlashcardQuiz?
    enum DisplayMode {
        case QuestionFirst
        case AnswerFirst
    }
    var CurrentDisplayMode : DisplayMode = .QuestionFirst
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        ManagedObjectContext = AppDelegate.persistentContainer.viewContext

    }
    override func viewDidAppear(_ animated: Bool) {
        ContainerQAView.bringSubview(toFront: QuestionView)
        FetchCards()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func FetchCards() {
        let FetchRequest : NSFetchRequest<FlashcardQuiz> = FlashcardQuiz.fetchRequest()
        do {
            ListOfCards = try ManagedObjectContext.fetch(FetchRequest)
            print("Cards fetched successfully")
            printCards()
        
        } catch {
            print("Error while fetching cards to managedObjectContext. Cards not fetched")
        }
    }
    func printCards() {
        for cards in ListOfCards {
            print(cards.question!)
            print(cards.answer!)
        }
    
    }

    @IBAction func SegmentDisplayModeAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            CurrentDisplayMode = .QuestionFirst
        } else {
            CurrentDisplayMode = .AnswerFirst
        }
    }
    
    @IBAction func DeleteCardAction(_ sender: UIButton) {
        if CurrentCard == nil {
            CardContentQuestionLabel.text = "No selected card to delete"
            return
        }
        
        let DeleteAlert = UIAlertController(title: "Delete this card?", message: "Are you sure you want to delete this card?", preferredStyle: .actionSheet)
        let Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(ACTION: UIAlertAction)->Void in})
        let Delete = UIAlertAction(title: "Delete", style: .destructive, handler: {(ACTION: UIAlertAction)->Void in
            self.ManagedObjectContext.delete(self.CurrentCard!)
            do {
                try self.ManagedObjectContext.save()
                print("Flashcard deleted successfully")
                self.FetchCards()
                self.DisplayCard()
            } catch {
                print("Couldn't deleted managedObjectContext state. Flashcard not deleted")
            }
        })
        DeleteAlert.addAction(Delete)
        DeleteAlert.addAction(Cancel)
        self.present(DeleteAlert, animated: true, completion: nil)
    }
    
    @IBAction func SwipeToAnswerAction(_ sender: UIButton) {
        if CurrentCard == nil { return }
        UIView.transition(from: QuestionView, to: AnswerView, duration: 0.5, options: [.transitionFlipFromLeft,.showHideTransitionViews])
        CardContentAnswerLabel.text = CurrentCard?.answer
    }
    @IBAction func SwipeToQuestionAction(_ sender: UIButton) {
        if CurrentCard == nil { return }
        UIView.transition(from: AnswerView, to: QuestionView, duration: 0.5, options: [.transitionFlipFromRight,.showHideTransitionViews])
        CardContentAnswerLabel.text = CurrentCard?.question
    }

    
    func DisplayCard() {
        ContainerQAView.bringSubview(toFront: QuestionView)
        let RandomIndex = Int(arc4random_uniform(UInt32(ListOfCards.count)))
        if ListOfCards.count == 0 {
            CardContentQuestionLabel.text = "No cards to display"
            return
        }
        CurrentCard = ListOfCards[RandomIndex]
        DisplayType(CardToDisplay: CurrentCard!)
    }
    
    func DisplayType(CardToDisplay: FlashcardQuiz) {
        if CurrentDisplayMode == .QuestionFirst {
            CardContentQuestionLabel.text = CardToDisplay.question
        } else {
            CardContentQuestionLabel.text = CardToDisplay.answer
        }
    }
    @IBAction func SwipeRightGesture(_ sender: UISwipeGestureRecognizer) {
        DisplayCard()
        
    }
}

/* let Tutorial = UIAlertController(title: "Welcome To Flashcard App", message: "Hi", preferredStyle: .actionSheet)
 //in the content area:\nSwipe right for new question\nSwipe up to display the question\nSwipe down to display the answer
 let OK = UIAlertAction(title: "Got it", style: .cancel, handler: {(ACTION: UIAlertAction)-> Void in})
 Tutorial.addAction(OK)
 self.present(Tutorial, animated: true, completion: nil)*/

