//
//  TestingViewController.swift
//  Vocabulary
//
//  Created by Alexandr Kurdyukov on 04.07.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class TestingViewController: UIViewController {

    var words = [String]()
    var translates = [String]()
    var wordCount = 0 {
        didSet {
            testingWord.text? = words[wordCount]
        }
    }
    
    @IBOutlet weak var testingWord: UILabel!
    
    @IBOutlet weak var answer: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        words.removeAll()
        translates.removeAll()
        saveWordsAndTranslates()
        testingWord.text? = words[wordCount]

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func saveWordsAndTranslates() {
        let result:[NSManagedObject] = DBW.getAllNotes()
        for data in result {
            words.append(data.value(forKey: "word") as! String)
            translates.append(data.value(forKey: "translate") as! String)
        }
    }
    
    @IBAction func getNextWord(_ sender: Any) {
        answer.text?.removeAll()
        
        if wordCount == words.count - 1 {
            wordCount = 0
        } else {
            wordCount += 1
        }
    }
    
    @IBAction func getRandomWord(_ sender: Any) {
        answer.text?.removeAll()
        wordCount = Int(arc4random_uniform(UInt32(words.count - 1)) + 1)
    }
    
    @IBAction func getVerification(_ sender: Any) {
        if answer.text == translates[wordCount] {
            print("verno")
            answer.text?.removeAll()
            if wordCount == words.count - 1 {
                wordCount = 0
            } else {
                wordCount += 1
            }
        } else {
            print("neverno")
            answer.text?.removeAll()
        }
    }
}
