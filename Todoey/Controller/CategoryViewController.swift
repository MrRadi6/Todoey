//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 12/14/18.
//  Copyright © 2018 MrRadix. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var catagoryDB: [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagoryDB.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        let category = catagoryDB[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = catagoryDB[indexPath.row]
        }
    }
    //MARK: ADDIGN NEW CATEGORY
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textInput = UITextField()
        let alert = UIAlertController(title: "Category", message: "Enter new Category", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
            let newCatagory = Category(context: self.context)
            newCatagory.name = textInput.text
            self.catagoryDB.append(newCatagory)
            self.savaData()
        }
        alert.addTextField { (textFielt) in
            textFielt.placeholder = "New Category"
            textInput = textFielt
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: SAVING TO DATABASE
    func savaData(){
        do{
            try context.save()
            tableView.reloadData()
        }
        catch{
            print("error while saving data to DB \(error)")
        }
    }
    //MARK: RELOAD THE DATA FROM THE DATABASE
    func reloadData(from request:NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            try catagoryDB = context.fetch(request)
            tableView.reloadData()
        }
        catch{
            print("error while reloading DB \(error)")
        }
    }
    
}
