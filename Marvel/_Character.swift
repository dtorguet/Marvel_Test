// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Character.swift instead.

import Foundation
import CoreData

public enum CharacterAttributes: String {
    case descriptionModel = "descriptionModel"
    case extensionUrl = "extensionUrl"
    case id = "id"
    case name = "name"
    case url = "url"
}

public enum CharacterRelationships: String {
    case pictureData = "pictureData"
}

open class _Character: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Character"
    }

    open class func entity(_ managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Character.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var descriptionModel: String

    @NSManaged open
    var extensionUrl: String

    @NSManaged open
    var id: NSNumber?

    @NSManaged open
    var name: String

    @NSManaged open
    var url: String

    // MARK: - Relationships

    @NSManaged open
    var pictureData: Photo

}

