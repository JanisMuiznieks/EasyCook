//
//  MyRecipesTableViewController.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//

import UIKit
import CoreData

class MyRecipesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myRecipe: [Recipes] = []
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewRecipeTapped(_ sender: Any) {
        addNewRecipe()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

        
    private func addNewRecipe() {
        let alertController = UIAlertController(title: "Add New Recipe.", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter Recipes Name"
            textField.autocapitalizationType = .sentences
            textField.autocorrectionType = .no
        }
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter Recipes Category"
            textField.autocapitalizationType = .sentences
            textField.autocorrectionType = .no
        }
        
        let addAction = UIAlertAction(title: "Add", style: .cancel) { (action: UIAlertAction) in
            let firstTextField = alertController.textFields![0]
            let secondTextField = alertController.textFields![1]
            
            let entity = NSEntityDescription.entity(forEntityName: "Recipes", in: self.context!)
            let item = NSManagedObject(entity: entity!, insertInto: self.context)
            item.setValue(firstTextField.text, forKey: "title")
            item.setValue(secondTextField.text, forKey: "category")
            //save function
            self.saveData()
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true)
        
        
    }
    
    func loadData(){
        let request: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        do{
            let result = try context?.fetch(request)
            myRecipe = result!
        }catch{
            fatalError(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    func saveData(){
        do {
            try self.context?.save()
        } catch {
            fatalError(error.localizedDescription)
        }
        loadData()
    }
        
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRecipe.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myRecipeCell", for: indexPath) as? MyRecipesTableViewCell else {return UITableViewCell()}
        
        let item = myRecipe[indexPath.row]
        cell.setUI(with: item)
                
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                 
                let recipe = self.myRecipe[indexPath.row]
                
                self.context?.delete(recipe)
                self.saveData()
            }))
            self.present(alert, animated: true)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeInfo" {
            // Get the new view controller using segue.destination.
                let vc = segue.destination as! AppInfoViewController
            // Pass the selected object to the new view controller.
                vc.infoText = "Here you can add and look up your own recipes"
        }
                
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        
        
        vc.titleString = myRecipe[indexPath.row].title ?? ""
        vc.categoryString = myRecipe[indexPath.row].category ?? ""
            
        
        
            navigationController?.pushViewController(vc, animated: true)
        }
}
