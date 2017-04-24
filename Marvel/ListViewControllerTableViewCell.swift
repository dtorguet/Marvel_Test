//
//  ListViewController.swift
//  Marvel
//
//  Created by David on 8/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import UIKit

class ListViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteView: UIImageView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.layer.cornerRadius = 5
        cellImageView.clipsToBounds = true
        favoriteView.isHidden = true
        
    }
    
    func setModel(model aModel: Model, favorite aFavorite: Bool) {
        if aFavorite{
        favoriteView.isHidden = false
        }else{
        favoriteView.isHidden = true
        }
        lbName.text = aModel.name as String
    }
}
