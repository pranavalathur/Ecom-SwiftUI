//
//  ContentEntity+CoreDataProperties.swift
//  
//
//  Created by admin on 11/10/24.
//
//

import Foundation
import CoreData


extension ContentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContentEntity> {
        return NSFetchRequest<ContentEntity>(entityName: "ContentEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var image_url: String?
    @NSManaged public var sku: String?
    @NSManaged public var product_name: String?
    @NSManaged public var product_image: String?
    @NSManaged public var actual_price: String?
    @NSManaged public var offer_price: String?
    @NSManaged public var discount: String?
    @NSManaged public var product_rating: Int64
    @NSManaged public var section: SectionEntity?

}
