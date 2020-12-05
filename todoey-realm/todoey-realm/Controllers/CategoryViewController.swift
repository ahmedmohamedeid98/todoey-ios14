//
//  ViewController.swift
//  todoey-realm
//
//  Created by Mac OS on 12/5/20.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipableViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    // Delete Category
    override func deleteCell(at indexPath: IndexPath) {
        if let category = categories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(category)
                }
            } catch {
                print("Can not delete category`")
            }
        }
    }
    
    // Load Categories
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    // Save Category
    func save(category: Category) {
        do {
            try realm.write{
                
                realm.add(category)
                
            }
            tableView.reloadData()
            
        } catch {
            print("Can not add new category!")
        }
    }
    
    // Add Category
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "add new category", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell_ID", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.monospacedSystemFont(ofSize: 24, weight: .medium)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItems" , sender: self)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemVC = segue.destination as! ItemViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            itemVC.title = categories?[indexPath.row].name
            itemVC.selectedCategory = categories?[indexPath.row]
        }
    }
}

