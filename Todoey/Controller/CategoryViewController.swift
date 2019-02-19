//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 12/14/18.
//  Copyright © 2018 MrRadix. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController:SwipeTableViewCellController {

//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var catagoryDB: [Category] = []
    let realmObj = try! Realm()
    var catagoryDB: Results<CatagoryRealm>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagoryDB?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = catagoryDB?[indexPath.row].name ?? "There is no saved Catagory"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCatagory = catagoryDB?[indexPath.row]
        }
    }
    
    //MARK: ADDIGN NEW CATEGORY
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textInput = UITextField()
        let alert = UIAlertController(title: "Category", message: "Enter new Category", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
//            let newCatagory = Category(context: self.context)
            let newCatagory: CatagoryRealm = CatagoryRealm()
            newCatagory.name = textInput.text!
//            self.catagoryDB.append(newCatagory)
            self.savaData(catagory: newCatagory)
        }
        alert.addTextField { (textFielt) in
            textFielt.placeholder = "New Category"
            textInput = textFielt
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: SAVING TO DATABASE
    func savaData(catagory: CatagoryRealm){
        do{
//            try context.save()
            try realmObj.write {
                realmObj.add(catagory)
            }
            tableView.reloadData()
        }
        catch{
            print("error while saving data to DB \(error)")
        }
    }
    
    //MARK: RELOAD THE DATA FROM THE DATABASE
    func reloadData(from request:NSFetchRequest<Category> = Category.fetchRequest()){
        catagoryDB = realmObj.objects(CatagoryRealm.self)
//        do{
//            try catagoryDB = context.fetch(request)
//            tableView.reloadData()
//        }
//        catch{
//            print("error while reloading DB \(error)")
//        }
    }
    
    //MARK: - DELETE THE SELECTED CELL
    override func deleteCellAtIndex(at indexPath: IndexPath) {
        if let cellToDelete = self.catagoryDB?[indexPath.row]{
            do{
                try self.realmObj.write {
                    self.realmObj.delete(cellToDelete)
                    //self.tableView.reloadData()
                }
            }
            catch{
                print("Error Deleting cell Error: \(error)")
            }
        }

    }
}
