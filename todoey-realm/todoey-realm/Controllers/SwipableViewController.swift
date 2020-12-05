//
//  SwipableViewController.swift
//  todoey-realm
//
//  Created by Mac OS on 12/5/20.
//

import UIKit

class SwipableViewController: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, cb) in
            
            self.deleteCell(at: indexPath)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            cb(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteCell(at indexPath: IndexPath) {
        // override this method on child class
    }


}
