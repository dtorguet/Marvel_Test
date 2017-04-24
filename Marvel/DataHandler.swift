//
//  DataHandler.swift
//  Marvel
//
//  Created by David on 8/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import Foundation
import UIKit

class DataHandler: NSObject,WebServicesDelegate {
    
    
    var delegate : DataHandlerDelegate?
    
    static let sharedInstance : DataHandler = {
        let instance = DataHandler()
        return instance
    }()

    func fetchCharactersFromApi(text aText: String,offset aOffsset: Int) -> Void {
        
        let ws : WebServices = WebServices.sharedInstance
        ws.delegate = self
        let newUrl = kUrl + kNameStart + aText + "&" + kLimit + kLimitValue + "&" + kOffset + String(aOffsset)
        ws.fetchCharacters(url: newUrl)
    }
    
    func imageFromUrl(model aModel : Model,cell aCell:ListViewControllerTableViewCell) -> Void {
        let ws : WebServices = WebServices.sharedInstance
        ws.delegate = self
        ws.imageFromUrl(model: aModel, cell: aCell)
    }
    
    func arrayFavorites() -> NSArray {
        let bm = BussinesManager.sharedInstance
        let array = bm.arrayFavorites()
        return array
    }

    // MARK: CoreData
    func arrayFavoritesInMemory() -> NSArray {
        let bm = BussinesManager.sharedInstance
        let arrayInMemory = bm.arrayFavoritesInMemory()
        return arrayInMemory
    }
    
    
    func checkFromFavoritesArray(model aModel: String) -> NSArray {
        let bm = BussinesManager.sharedInstance
        let arrayF = bm.checkFromFavoritesArray(model: aModel)
        return arrayF
    }
    
    func saveModel(model aModel: Model,imageData aImageData: Data) -> Void {
        let bm = BussinesManager.sharedInstance
        bm.saveModel(model: aModel, imageData: aImageData)
    }
    
    func removeModel(character aCharacter: Character, model aModel: Model) -> Void {
        let bm = BussinesManager.sharedInstance
        bm.removeModel(character: aCharacter, model: aModel)
    }
    
    
    
    // MARK: - WebServicesDelegate
    func dictionaryOfCharacters(dict aDictOfCharacters: NSDictionary) {
        
        let manager = BussinesManager.sharedInstance
        let arrayModels = manager.arrayOfCharactersModels(dict: aDictOfCharacters)
        self.delegate?.arrayOfModels(array: arrayModels)
    }
    func imageFromUrl(image aImage: UIImage, cell aCell: ListViewControllerTableViewCell, model aModel: Model){
     self.delegate?.imageFromUrl(image: aImage, cell: aCell,model: aModel)
    }
}

