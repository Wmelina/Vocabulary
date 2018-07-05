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
        addTapGestureToHideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    private func saveWordsAndTranslates() {
        let result:[NSManagedObject] = DBW.getAllNotes()
        for data in result {
            words.append(data.value(forKey: "word") as! String)
            translates.append(data.value(forKey: "translate") as! String)
        }
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
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
        
        if words.count > 2 {
            answer.text?.removeAll()
            wordCount = Int(arc4random_uniform(UInt32(words.count - 1)) + 1)
        } else {//polu-kostil'. krivoy random ot apple, spasibo sooqa.
            if wordCount == 0 {
                if words.count > 1 {
                wordCount = 1
                }
            } else {
                wordCount = 0
            }
        }
    }
    
    @IBAction func getVerification(_ sender: Any) {
        let str = answer.text!
        if str.removingWhitespaces().lowercased() == translates[wordCount] {
            HelpingActions.okAlert(title: "Верно", message: "Вы указали верный перевод!", view: self)
            print("verno")
            answer.text?.removeAll()
            if wordCount == words.count - 1 {
                wordCount = 0
            } else {
                wordCount += 1
            }
        } else {
            HelpingActions.okAlert(title: "Неверно", message: "Перевод некорректен!", view: self)
            print("neverno")
            answer.text?.removeAll()
        }
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }  //if we have white space in the end of the str
}      //we will delete it with this func

