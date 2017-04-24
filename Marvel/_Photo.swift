// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Photo.swift instead.

import Foundation
import CoreData

public enum PhotoAttributes: String {
    case photoModel = "photoModel"
}

public enum PhotoRelationships: String {
    case dataOfPhoto = "dataOfPhoto"
}

open class _Photo: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Photo"
    }

    open class func entity(_ managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Photo.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var photoModel: Data

    // MARK: - Relationships

    @NSManaged open
    var dataOfPhoto: Character?

}

