//
//  SwipeTableViewCellController.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 1/29/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import Foundation
import SwipeCellKit

class SwipeTableViewCellController: UITableViewController,SwipeTableViewCellDelegate{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.deleteCellAtIndex(at: indexPath)            
            print("Cell deleted")
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "Trash-Icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    //MARK: - Delete Abstract Method
    func deleteCellAtIndex(at indexPath: IndexPath){
        // code to handling deleting Cell at Child Class
    }
}
