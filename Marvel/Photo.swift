import Foundation
import CoreData

@objc(Photo)
open class Photo: _Photo {
	// Custom logic goes here.
    
    convenience init?(photoData: Data, context: NSManagedObjectContext){
        self.init(managedObjectContext: context)
        self.photoModel = photoData
    }
}
