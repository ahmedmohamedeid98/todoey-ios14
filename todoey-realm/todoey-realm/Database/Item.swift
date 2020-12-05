//
//  Item.swift
//  todoey-realm
//
//  Created by Mac OS on 12/5/20.
//

import RealmSwift

class Item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    let category = LinkingObjects(fromType: Category.self, property: "items")
}
