//
//  DetailViewController.swift
//  Marvel
//
//  Created by David on 9/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import UIKit
import CoreData
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class DetailViewController: UIViewController {
    
    var model: Model? = nil
    var thumbnailImage: UIImage? = nil
    var _isFavorite: Bool = false
    var arrayFavorites: NSArray = NSMutableArray()
    var modelContext: DVDCoreDataStack = DVDCoreDataStack(modelName: kModelCoreData)
    var objectModel: Character?
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbNameText: UILabel!
    @IBOutlet weak var lbDescriptionText: UITextView!
    @IBOutlet weak var btFavorite: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dh = DataHandler.sharedInstance
        let array = dh.checkFromFavoritesArray(model: (self.model?.name)!)
        if (array.count > 0) {
            _isFavorite = true
            self.objectModel = array[0] as? Character
        }else{
            _isFavorite = false
        }
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
        updateButton(_isFavorite)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    //MARK: - Buttons
    @IBAction func btFavoriteAction(_ sender: AnyObject) {
      
        if (_isFavorite) {
            //remove
            let dh = DataHandler.sharedInstance
            let array = dh.checkFromFavoritesArray(model: (self.model?.name)!)
            self.objectModel = array[0] as? Character
            dh.removeModel(character: self.objectModel!, model: self.model!)
            _isFavorite = false
            updateButton(false)
        }else{
            //add
            let imageData: Data = UIImagePNGRepresentation(self.thumbnailImage!)!
            let dh = DataHandler.sharedInstance
            dh.saveModel(model: self.model!, imageData: imageData)
            _isFavorite = true
            updateButton(true)
        }
        
    }
    
    @IBAction func btClose(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    // MARK: - Private Methods
    
    func initViews() -> Void {
        
        self.thumbnailView.layer.cornerRadius = 5
        self.thumbnailView.clipsToBounds = true
        self.btFavorite.layer.cornerRadius = 5
        self.btFavorite.clipsToBounds = true
        self.thumbnailView.layer.borderWidth = 4
    }
    
    func updateLabels() -> Void {
        self.lbName.text = kLbNameTitle
        self.lbNameText.text = self.model?.name
        self.lbDescription.text = kLbDescriptionTitle
        if (model?.descriptionModel.characters.count > 0) {
            self.lbDescriptionText.text = model?.descriptionModel
        }else{
            self.lbDescriptionText.text = kNoDescriptionText
        }
        
        if let image : UIImage = self.thumbnailImage{
            self.thumbnailView.image = image
        }else{
            self.thumbnailView.image = #imageLiteral(resourceName: "background")
        }
    }
    
    func updateButton(_ isFavorite: Bool) -> Void {
        
        if (!isFavorite) {
            self.btFavorite.setTitle(kButtonFavoritesTitleSave, for: UIControlState())
            self.btFavorite.backgroundColor = UIColor.green
            self.thumbnailView.layer.borderColor = UIColor.green.cgColor
            
        }else{
            self.btFavorite.setTitle(kButtonFavoritesTitleRemove, for: UIControlState())
            self.btFavorite.backgroundColor = UIColor.red
            self.thumbnailView.layer.borderColor = UIColor.red.cgColor
        }
    }
}
