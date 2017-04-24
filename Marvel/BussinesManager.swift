//
//  BussinesManager.swift
//  Marvel
//
//  Created by David on 8/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import Foundation
import CoreData

var modelContext: DVDCoreDataStack = DVDCoreDataStack(modelName: kModelCoreData)

class BussinesManager: NSObject {
    
   
    
    static let sharedInstance : BussinesManager = {
        let instance = BussinesManager()
        return instance
    }()

    func arrayOfCharactersModels(dict aDict : NSDictionary) -> NSArray {
        
        var arrayOfCharacters = [Model]()
        
        if let data = aDict["data"]{
            let newData: NSDictionary = data as! NSDictionary
            if let models = newData["results"]{
                let newModels: NSArray = models as! NSArray
                for i in 0 ..< (models as! NSArray).count {
                    let item =  newModels[i] as! NSDictionary
                    let model = Model(dict:item)
                    arrayOfCharacters.append(model)
                }
            }
        }
        return arrayOfCharacters as NSArray
    }
    
    func arrayFavorites() -> NSArray {
        
        let defaults = UserDefaults.standard
        let array = defaults.object(forKey: kArrayFavorites) as? [String] ?? [String]()
        return array as NSArray
    }
    
    func saveArrayFavorites(array aArray:NSArray) -> Void {
        
        let defaults = UserDefaults.standard
        defaults.set(aArray, forKey: kArrayFavorites)
        defaults.synchronize()
    }
    
    // MARK: - CoreData
    
    func arrayFavoritesInMemory() -> NSArray {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: Character.entityName())
        req.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            let array = try modelContext.context.fetch(req)
            if (array.count > 0) {
                return array as NSArray
            }else{
                
            }
        } catch let error as NSError {
            
            print("Fetch failed: \(error.localizedDescription)")
        }
        return [NSArray]() as NSArray
    }
    
    func checkFromFavoritesArray(model aModel: String) -> NSArray {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: Character.entityName())
        req.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        req.predicate = NSPredicate(format: "name = %@", (aModel))
        do {
            let array = try modelContext.context.fetch(req)
            if (array.count > 0) {
               return array as NSArray
            }else{
               
            }
        } catch let error as NSError {
            
            print("Fetch failed: \(error.localizedDescription)")
        }
        return [NSArray]() as NSArray
    }
    
    func saveModel(model aModel: Model, imageData aImageData: Data) -> Void {
        
        let object = Character(name: (aModel.name), descriptionModel: (aModel.descriptionModel), id: (aModel.id), extensionUrl: (aModel.extensionUrl), url: (aModel.url), context: (modelContext.context))
        let photo = Photo(photoData: aImageData, context: (modelContext.context))
        object?.pictureData = photo!
        modelContext.saveWithErrorBlock{ (err) in
            print("Error al guardar: \(String(describing: err))")
        }
        let newArray = self.arrayFavorites().mutableCopy()
        (newArray as AnyObject).add(aModel.name)
        self.saveArrayFavorites(array: newArray as! NSArray)
    }
    
    func removeModel(character aCharacter: Character, model aModel: Model) -> Void {
        modelContext.delete(aCharacter)
        modelContext.saveWithErrorBlock{ (err) in
            print("Error: \(String(describing: err))")
        }
        let newArray = self.arrayFavorites().mutableCopy()
        (newArray as AnyObject).remove(aModel.name)
        self.saveArrayFavorites(array: newArray as! NSArray)
    }
}


