import Foundation
import CoreData

@objc(Character)
open class Character: _Character {
	// Custom logic goes here.
    
    
    convenience init?(name aName: String, descriptionModel aDescriptionModel: String,id aId: NSNumber,extensionUrl aExtensionUrl: String,url aUrl: String, context: NSManagedObjectContext){
        self.init(managedObjectContext:context)
        self.name = aName
        self.descriptionModel = aDescriptionModel
        self.id = aId
        self.extensionUrl = aExtensionUrl
        self.url = aUrl
        
    }
}
