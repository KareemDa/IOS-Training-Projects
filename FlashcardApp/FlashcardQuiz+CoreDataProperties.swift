//
//  FlashcardQuiz+CoreDataProperties.swift
//  FlashcardApp
//
//  Created by khalil on 8/26/18.
//  Copyright © 2018 Ejad. All rights reserved.
//
//

import Foundation
import CoreData


extension FlashcardQuiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashcardQuiz> {
        return NSFetchRequest<FlashcardQuiz>(entityName: "FlashcardQuiz")
    }

    @NSManaged public var question: String?
    @NSManaged public var answer: String?

}
