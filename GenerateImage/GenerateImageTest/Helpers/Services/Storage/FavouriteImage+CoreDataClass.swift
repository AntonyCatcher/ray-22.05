//
//  FavouriteImage+CoreDataClass.swift
//  GenerateImageTest
//
//  Created by Anton  on 25.05.2023.
//
//

import Foundation
import CoreData


public class FavouriteImage: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteImage> {
        return NSFetchRequest<FavouriteImage>(entityName: "FavouriteImage")
    }
    
    var newImageData: Data {
        return imageData ?? Data()
    }
    var newUserQuery: String {
        return userQuery ?? ""
    }
    var newAddedDate: Date {
        return addedDate ?? Date()
    }

    @NSManaged public var addedDate: Date?
    @NSManaged public var imageData: Data?
    @NSManaged public var userQuery: String?
}
