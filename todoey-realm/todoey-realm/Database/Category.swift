//
//  Category.swift
//  todoey-realm
//
//  Created by Mac OS on 12/5/20.
//

import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let list = List<Item>()
}
