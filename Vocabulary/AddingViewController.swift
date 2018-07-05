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
            if DBW.checkForEntrance(word: word.text!.lowercased()) {
                HelpingActions.okAlert(title: "Ошибка", message: "Такое слово уже есть!", view: self)
                word.text?.removeAll()
                translate.text?.removeAll()
                print("uje est' slovo takoe, suka glupaya")
            } else {
                DBW.addToDB(word: word.text!.lowercased(), translate: translate.text!.lowercased())
                HelpingActions.okAlert(title: "Успех", message: "Слово успешно добавлено!", view: self)
                print("uspeshno dobavleno. alert")
                word.text?.removeAll()
                translate.text?.removeAll()
                
            }
        } else {
            HelpingActions.okAlert(title: "Ошибка", message: "Нужно заполнить оба поля.", view: self)
            print("zdes' budet alert. net teksta!")
        }
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    

    
}
