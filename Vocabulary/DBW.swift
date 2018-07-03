//
//  DBW.swift
//  Vocabulary
//
//  Created by Alexandr Kurdyukov on 03.07.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class DBW : NSObject {
    
     public static func checkForEntrance(word: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if data.value(forKey: "word") as! String == word {
                    return true
                }
            }
        } catch {
            print("Failed")
        }
        return false
    }
    
    public static func getAllNotes() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        var result:Any? = nil
        do {
            result = try context.fetch(request)
        } catch {
            print("Failed")
        }
        return result as! [NSManagedObject]

    }
    
    public static func addToDB(word: String, translate: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEntry = NSManagedObject(entity: entity!, insertInto: context)
        newEntry.setValue(word, forKey: "word")
        newEntry.setValue(translate, forKey: "translate")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
