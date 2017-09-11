//
//  AddVC.swift
//  CoreDataDemo
//
//  Created by Stefan Markovic on 9/11/17.
//  Copyright © 2017 Stefan Markovic. All rights reserved.
//

import UIKit

class AddVC: UIViewController {

    @IBOutlet weak var addTaskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addTaskBtnPressed(_ sender: UIButton) {
        guard let enteredText = addTaskTextField?.text else {
            return
        }
        
        if enteredText.isEmpty ||  addTaskTextField?.text == "Enter your task"{
            let alert = UIAlertController(title: "Please Type Something", message: "Your entry was left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
            })
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            guard let entryText = addTaskTextField?.text else {
                return
            }
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Task(context: context)
            newEntry.name = entryText
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            let _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
    

}
