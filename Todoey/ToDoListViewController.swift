//
//  ViewController.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 12/8/18.
//  Copyright © 2018 MrRadix. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Item_1","Item_2","Item_3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - TableView Data Source Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: tableView cell tap on
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        print(itemArray[indexPath.row])
    }
    
    //MARK: adding new item
    
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let addNewAlert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        let addNewAction = UIAlertAction(title: "ADD NEW", style: .default) {   (action) in
            print("action triggered")
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            print(self.itemArray.last!)
        }
        
        addNewAlert.addTextField {  (alertTextField) in
            alertTextField.placeholder = "NEW ITEM LIST"
            textField = alertTextField
        }
        addNewAlert.addAction(addNewAction)
        present(addNewAlert, animated: true, completion: nil)
    }
    
}

