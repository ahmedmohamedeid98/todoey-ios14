//
//  ItemViewController.swift
//  todoey-realm
//
//  Created by Mac OS on 12/5/20.
//

import UIKit

class ItemViewController: SwipableViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item1 = Item()
        item1.name = "I will safe the world tomorow"
        let item2 = Item()
        item2.name = "finish all my home work"
        item2.done = true
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell_ID", for: indexPath)
        cell.textLabel?.text = "items[indexPath.row].name"
        cell.accessoryType = .checkmark//items[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = items[indexPath.row].done ? .none : .checkmark
        items[indexPath.row].done = !items[indexPath.row].done
    }
    
}
