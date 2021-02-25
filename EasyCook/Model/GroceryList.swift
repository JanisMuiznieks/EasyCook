//
//  GroceryList.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//

import Foundation
import RealmSwift

class GroceryList: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    let groceries = List<Groceries>()
}
