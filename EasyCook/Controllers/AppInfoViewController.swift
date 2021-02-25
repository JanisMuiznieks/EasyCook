//
//  AppInfoViewController.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//

import UIKit

class AppInfoViewController: UIViewController {

    @IBOutlet weak var appInfoLabel: UILabel!
    @IBOutlet weak var appDescLabel: UILabel!
    
    var infoText = String()
    let appDescText = "This app is a Accenture bootcamp project!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDescLabel.text = appDescText
        
        if !infoText.isEmpty {
            appInfoLabel.text = infoText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
