//
//  MyRecipesTableViewCell.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//

import UIKit

class MyRecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setUI(with: Recipes){
        titleLabel.text = with.title
        categoryLabel.text = with.category
    }

}
