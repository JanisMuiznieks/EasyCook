//
//  DetailViewController.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//
import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var myRecipe = [Recipes]()
    var context: NSManagedObjectContext?
    var imagePicker = UIImagePickerController()
       
    var titleString = String()
    var categoryString = String()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var recipeView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        categoryLabel.text = categoryString
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        loadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let fetch = DataBaseHelper.shareInstance.fetchImage()
//        recipeImageView.image = UIImage(data: fetch[0].image!)
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset: Float = Float(scrollView.contentOffset.y)
        if scrollOffset < 0 {
            navigationController?.hidesBarsOnSwipe = false
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        else {
            navigationController?.hidesBarsOnSwipe = true
        }
    }
    func loadData(){
        let request: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        do{
            let result = try context?.fetch(request)
            myRecipe = result!
            recipeView.reloadData()
        }catch{
            fatalError("Error in retrieving Photo item")
        }
        
    }
    func addPhoto(with image: UIImage){
            let pickItem = Recipes(context: context!)
        pickItem.image = NSData(data: image.jpegData(compressionQuality: 0.1)!) as Data
        
        do {
            try self.context?.save()
            self.loadData()
        } catch {
            print("Could not save data \(error.localizedDescription)")
        }
    }
    
    @IBAction func changeImageTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Select Image Source", message: "Please Select a Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Choose a Photo", style: .default, handler: { (UIAlertAction) in
            print("User clicked Photos btn")
            
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
            }))
        alert.addAction(UIAlertAction(title: "Take a New Photo", style: .default, handler: { (UIAlerAction) in
            print("User clicked Camera btn")
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.delegate = self
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                self.warningPopUp(withTitle: "No Camera", withMessage: "Device without camera!")
            }
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (UIAlertAction) in
                print("User clicked Dismiss btn")
        }))
        self.present(alert, animated: true,completion:  {
            print("Completion block")
        })
        
    
    }
    
    
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myRecipe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as? DetailCollectionViewCell else {return  UICollectionViewCell()}
        
        let pins = myRecipe[indexPath.row]
        print(pins.image as Any)
        
        let imageview : UIImageView = UIImageView(frame: CGRect(x: 50, y: 0, width: 200, height: 200));
        
        if let imageData = pins.value(forKey: "image") as? NSData {
            if let dataImage = UIImage(data:imageData as Data) {
                imageview.image = dataImage
                cell.contentView.addSubview(imageview)
            }
        }
        
        return cell
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            picker.dismiss(animated: true, completion: nil)
            self.addPhoto(with: pickedImage)
        }
        
    }
    
    func warningPopUp(withTitle title : String?, withMessage message : String?){
        DispatchQueue.main.async {
            
            let popUP = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            popUP.addAction(okButton)
            self.present(popUP, animated: true, completion: nil)
        }
    }
    
    
    
}

