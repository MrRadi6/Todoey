//
//  ViewController.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 12/8/18.
//  Copyright © 2018 MrRadix. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{

    var itemArray: [Data] = []
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
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
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.item
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
    
    //MARK: tableView cell tap on
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked
        savaData()
        print(itemArray[indexPath.row])
    }
    
    //MARK: adding new item
    
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let addNewAlert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        let addNewAction = UIAlertAction(title: "ADD NEW", style: .default) {   (action) in
            print("action triggered")
            self.itemArray.append(Data(item: textField.text!,isChecked: false))
            self.savaData()
           // self.defaults.set(self.itemArray, forKey: "UserItemList")
            print(self.itemArray.last!)
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
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            tableView.reloadData()
        }
        catch{
            print("Error Encoding Data for P_list")
        }
    }
    
    //MARK: Loading data from Property list -- error during calling Data()
    /*func loadData(){
        let decoder = PropertyListDecoder()
        do{
           let data = try Data(contentOf: dataFilePath!)
            itemArray = try decoder.decode([Data].self, from: data)
        }
        catch{
                print("error during decoding p_list")
        }
    }*/
    
}

