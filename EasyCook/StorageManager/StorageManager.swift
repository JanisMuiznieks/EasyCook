//
//  StorageManager.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//

import RealmSwift
let realm = try! Realm()

class StorageManager {
    //MARK: - TASKS LISTS METHODS

    static func saveGroceryList(_ groceryList: GroceryList){
        try! realm.write {
            realm.add(groceryList)
        }
    }
    static func deleteList(_ groceryList: GroceryList){
        try! realm.write {
            let groceries = groceryList.groceries
            realm.delete(groceries)
            realm.delete(groceryList)
        }
    }
    static func editList(_ groceryList: GroceryList, newListName: String){
        try! realm.write {
            groceryList.name = newListName
        }

    }
    static func makeAllDone(_ groceryList: GroceryList){
            try! realm.write {
                groceryList.groceries.setValue(true, forKey: "isComplete")
        }
}
    //MARK: Individual Task Method

    static func saveTask(_ groceryList: GroceryList, task: Groceries){
        try! realm.write {
            groceryList.groceries.append(task)
        }

    }
    static func editTask(_ groceries: Groceries, newTask: String, newNote: String){
        try! realm.write {
            groceries.note = newNote
            groceries.name = newTask
            
        }

    }
    static func deleteTask(_ groceries: Groceries){
        try! realm.write {
            realm.delete(groceries)

        }
    }
    static func makeDone(_ groceries: Groceries){
            try! realm.write {
                groceries.isComplete.toggle()
        }
    }

}
