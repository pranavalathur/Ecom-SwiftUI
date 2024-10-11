//
//  SectionEntity+CoreDataProperties.swift
//  
//
//  Created by admin on 11/10/24.
//
//

import Foundation
import CoreData


extension SectionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SectionEntity> {
        return NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var type: String?
    @NSManaged public var title: String?
    @NSManaged public var contents: NSSet?

}

// MARK: Generated accessors for contents
extension SectionEntity {

    @objc(addContentsObject:)
    @NSManaged public func addToContents(_ value: ContentEntity)

    @objc(removeContentsObject:)
    @NSManaged public func removeFromContents(_ value: ContentEntity)

    @objc(addContents:)
    @NSManaged public func addToContents(_ values: NSSet)

    @objc(removeContents:)
    @NSManaged public func removeFromContents(_ values: NSSet)

}
