//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Stefan Markovic on 9/11/17.
//  Copyright © 2017 Stefan Markovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [Task]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        myTableView.reloadData()
    }
    
    
    func fetchData() {
        
        do {
            items = try context.fetch(Task.fetchRequest())
            print(items)
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let task = items[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                items = try context.fetch(Task.fetchRequest())
            }
            catch {
                print("Fetching Failed")
            }
        }
        myTableView.reloadData()
    }
    
    
    
    
    
}





