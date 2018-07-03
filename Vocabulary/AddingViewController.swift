//
//  AddingViewController.swift
//  Vocabulary
//
//  Created by Alexandr Kurdyukov on 03.07.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit

class AddingViewController: UIViewController {

    @IBOutlet weak var word: UITextField!
    @IBOutlet weak var translate: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
    }

    @IBAction func addWord(_ sender: Any) {
        if word.text! != "" && translate.text! != "" {
            if DBW.checkForEntrance(word: word.text!) {
                print("uje est' slovo takoe, suka glupaya")
            } else {
            DBW.addToDB(word: word.text!, translate: translate.text!)
            print("uspeshno dobavleno. alert")
            word.text = ""
            translate.text = ""
                
            }
        } else {
            print("zdes' budet alert. net teksta!")
        }
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    

    
}
