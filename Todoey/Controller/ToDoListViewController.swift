//
//  ViewController.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 12/8/18.
//  Copyright © 2018 MrRadix. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController{

    var itemArray: [Data] = []
    var itemsDB: [Item] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var selectedCategory: Category?{
        didSet{
            loadData()
        }
    }
    // var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
                print(dataFilePath!)
        
       /* if let userItems = defaults.array(forKey: "UserItemList") as? [Data]{
            itemArray = userItems
        }*/
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - TableView Data Source Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsDB.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        let item = itemsDB[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //MARK: tableView cell tap on
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //context.delete(itemsDB[indexPath.row])
        //itemsDB.remove(at: indexPath.row)
        //itemsDB[indexPath.row].setValue(!itemsDB[indexPath.row].done, forKey: "done")
        
        itemsDB[indexPath.row].done = !itemsDB[indexPath.row].done
        savaData()
        //print(itemsDB[indexPath.row])
    }
    
    //MARK: adding new item
    
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let addNewAlert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        let addNewAction = UIAlertAction(title: "ADD NEW", style: .default) {   (action) in
            print("action triggered")
            let newItem = Item(context: self.context)
            newItem.title = textField.text
            newItem.parentCategory = self.selectedCategory
            self.itemsDB.append(newItem)
            self.savaData()
           // self.defaults.set(self.itemArray, forKey: "UserItemList")
            print(self.itemsDB.last!)
        }
        
        addNewAlert.addTextField {  (alertTextField) in
            alertTextField.placeholder = "NEW ITEM LIST"
            textField = alertTextField
        }
        addNewAlert.addAction(addNewAction)
        present(addNewAlert, animated: true, completion: nil)
    }
    
    //MARK: Saving Data to Document in User Directory
    func savaData(){
       // let encoder = PropertyListEncoder()
        do{
           // let data = try encoder.encode(itemArray)
           // try data.write(to: dataFilePath!)
            try context.save()
            tableView.reloadData()
        }
        catch{
            print("Error saving Data \(error)")
        }
    }
    
    //MARK: Loading data from Property list -- error during calling Data()
    func loadData(from request: NSFetchRequest<Item> = Item.fetchRequest(), rule predicate:NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
        do{
            if let additionalPredicate = predicate{
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
            }
            else{
                request.predicate = categoryPredicate
            }
            itemsDB = try context.fetch(request)
            tableView.reloadData()
        }
        catch{
            print("error during fetching data: \(error)")
        }
        /* let decoder = PropertyListDecoder()
        do{
           let data = try Data(contentOf: dataFilePath!)
            itemArray = try decoder.decode([Data].self, from: data)
        }
        catch{
                print("error during decoding p_list")
        }*/
    }
    
}

// MARK: UISearchBar methods
extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadData(from: request,rule: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
               searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadData()
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
}
