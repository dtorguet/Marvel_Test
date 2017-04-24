//
//  Protocols.swift
//  Marvel
//
//  Created by David on 8/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import Foundation
import UIKit

protocol WebServicesDelegate {
    
    func dictionaryOfCharacters(dict aDictOfCharacters : NSDictionary) -> Void
    func imageFromUrl(image aImage : UIImage,cell aCell:ListViewControllerTableViewCell,model aModel:Model) -> Void
}

protocol DataHandlerDelegate {
    func arrayOfModels(array aArrayOfModels : NSArray) -> Void
    func imageFromUrl(image aImage : UIImage,cell aCell:ListViewControllerTableViewCell,model aModel:Model) -> Void
}