//
//  Model.swift
//  Marvel
//
//  Created by David on 8/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import Foundation


class Model: NSObject {
    
    var id : NSNumber = 0
    var name : String = ""
    var descriptionModel: String = ""
    var url : String = ""
    var extensionUrl : String = ""
    
    var thumbnailDict = NSDictionary()

    init(dict : NSDictionary) {
        self.id = dict["id"] as? NSNumber ?? 0
        self.name = dict["name"] as? String ?? kNoName
        self.descriptionModel = dict["description"] as? String ?? kNoName
        self.thumbnailDict = dict["thumbnail"] as? NSDictionary ?? NSDictionary()
        self.extensionUrl = self.thumbnailDict["extension"] as? String ?? kNoName
        self.url = self.thumbnailDict["path"] as? String ?? kNoName
    }
}