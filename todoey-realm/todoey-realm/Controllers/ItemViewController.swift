//
//  ItemViewController.swift
//  todoey-realm
//
//  Created by Mac OS on 12/5/20.
//

import UIKit
import RealmSwift


class ItemViewController: SwipableViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var selectedCategory:Category?
    var items: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell_ID", for: indexPath)
        if let itemList = items {
            cell.textLabel?.text = itemList[indexPath.row].name
            cell.accessoryType   = itemList[indexPath.row].done ? .checkmark : .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let itemList = items {
            cell?.accessoryType = itemList[indexPath.row].done ? .none : .checkmark
            
            do {
                try realm.write {
                    itemList[indexPath.row].done = !itemList[indexPath.row].done
                }
            } catch {
                print("can not update List")
            }
            
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func deleteCell(at indexPath: IndexPath) {
        if let selectedItem = items?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(selectedItem)
                }
            } catch {
                print("Can not delete item")
            }
        }
    }
    
    func save(item: Item) {
        do {
            try realm.write {
                selectedCategory?.items.append(item)
            }
            self.tableView.reloadData()
        }
        catch { print("Field to add new item to the category") }
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField  = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        let add   = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let itemTitle = textField.text {
                let newItem = Item()
                newItem.name = itemTitle
                self.save(item: newItem)
            }
        }
        alert.addTextField { (field) in
            textField = field
        }
        
        alert.addAction(add)
        
        self.present(alert, animated: true)
    }
}
