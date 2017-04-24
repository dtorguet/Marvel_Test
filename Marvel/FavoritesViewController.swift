//
//  FavoritesViewController.swift
//  Marvel
//
//  Created by David on 9/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import UIKit

var arrayOfFavorites = NSArray()


class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getArrayFavorites()
        if (arrayOfFavorites.count > 0) {
            for object in arrayOfFavorites {
                let positionRandom = pointRandomInView()
                let button = buttonOfModel(frame:CGRect(x: positionRandom.0, y: positionRandom.1, width: 100, height: 100))
                button.setModel(model: object as! Character)
                
                self.view.addSubview(button)
            }
        }else{
            let alert=UIAlertController(title: kAlertNoFavoritesTitle, message: kAlertNoFavoritesText, preferredStyle: UIAlertControllerStyle.alert);
            
            alert.addAction(UIAlertAction(title: kOk, style: UIAlertActionStyle.cancel, handler: nil));
            present(alert, animated: true, completion: nil);
        }
        
    }
    
    func pointRandomInView() -> (posX:CGFloat, posY:CGFloat) {
        let px : CGFloat = CGFloat(drand48())
        let py : CGFloat = CGFloat(drand48())
        let screenSize : CGRect = self.view.frame
        var location = CGPoint(x: screenSize.width*px,y: screenSize.height*py)
        if (location.x < 0) {
            location.x = location.x + 200
        }
        if (location.y > self.view.frame.size.width) {
            location.y = location.y - 200
        }
        if (location.y < 0) {
            location.y = location.y + 200
        }
        if (location.y > self.view.frame.size.height) {
            location.y = location.y - 200
        }
        return (location.x, location.y)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func getArrayFavorites() -> Void {
        let dh = DataHandler.sharedInstance
        let array = dh.arrayFavoritesInMemory()
        arrayOfFavorites = array
    }
    
}
