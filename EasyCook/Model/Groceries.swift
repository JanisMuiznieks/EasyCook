//
//  Groceries.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//

import Foundation
import RealmSwift


class Groceries: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    @objc dynamic var note = ""
    @objc dynamic var isComplete = false
}
