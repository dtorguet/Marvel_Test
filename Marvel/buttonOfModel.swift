//
//  buttonOfModel.swift
//  Marvel
//
//  Created by David on 10/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import UIKit


class buttonOfModel: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setModel(model aModel: Character) -> Void {

        let photoModel: Photo = (aModel.pictureData)
        let photoData: Data = NSData(data: (photoModel.photoModel) as Data) as Data
        let image : UIImage = UIImage(data: (photoData))!
        self.setImage(image, for: UIControlState())
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(buttonOfModel.moveButton(_:)))
        self.addGestureRecognizer(gesture)
        
    }
    func moveButton(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began || gestureRecognizer.state == UIGestureRecognizerState.changed {
            let translation = gestureRecognizer.translation(in: superview)
            
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            
            gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: superview)
        }
        superview?.bringSubview(toFront: self)
    }
    
}
