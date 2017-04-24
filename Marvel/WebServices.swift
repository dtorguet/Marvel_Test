//
//  WebServices.swift
//  Marvel
//
//  Created by David on 8/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import Foundation
import UIKit


class WebServices {
    
    
    var arrayOfCharacters = [Model]()
    var delegate:WebServicesDelegate?
    
    static let sharedInstance : WebServices = {
        let instance = WebServices()
        return instance
    }()

    func fetchCharacters(url fromUrl:String) {
        
        let url: URL = URL(string: fromUrl as String)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            data, response, error in
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            do {
                if let dict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    DispatchQueue.main.async(execute: {
                        self.delegate?.dictionaryOfCharacters(dict: dict)
                    })
                }
            } catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }) 
        task.resume()
    }
    
    func imageFromUrl(model aModel : Model,cell aCell:ListViewControllerTableViewCell) -> Void {
        
        let stringOfUrlPlusExtension = aModel.url + ".\(aModel.extensionUrl)"
        let url: URL = URL(string: stringOfUrlPlusExtension as String)!
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async(execute: {
                    let image : UIImage? = UIImage(data: data)
                    if image != nil{
                        self.delegate?.imageFromUrl(image: image!,cell: aCell,model: aModel)
                    }
                });
            }
           
        }
    }
}
