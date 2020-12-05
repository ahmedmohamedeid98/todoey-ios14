//
//  ViewController.swift
//  todoey-realm
//
//  Created by Mac OS on 12/5/20.
//

import UIKit

class CategoryViewController: SwipableViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cat1 = Category()
        cat1.name = "Category 1"
        let cat2 = Category()
        cat2.name = "Category 2"
        
        categories = [cat1, cat2]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell_ID", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItems" , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemVC = segue.destination as! ItemViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            itemVC.title = categories[indexPath.row].name
        }
    }
    
    override func deleteCell(at indexPath: IndexPath) {
        categories.remove(at: indexPath.row)
    }

}

