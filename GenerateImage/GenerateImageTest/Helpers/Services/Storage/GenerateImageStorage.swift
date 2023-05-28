//
//  GenerateImageStorage.swift
//  GenerateImageTest
//
//  Created by Anton  on 24.05.2023.
//

import Foundation
import CoreData

//MARK: - GenerateImageStorageProtocol
protocol GenerateImageStorageProtocol {
    
    func fetchFavouriteImages() -> [FavouriteImage]
    func save()
    func addFavourite(_ imageData: Data, userQuery: String)
    func removeFavourite(_ image: FavouriteImage)
}

final class GenerateImageStorage: GenerateImageStorageProtocol {
    
    static let shared = GenerateImageStorage()
    let picLimit = 3
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GenerateImageTest")
        container.loadPersistentStores { _, _ in }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {}
}

extension GenerateImageStorage {
    
    func fetchFavouriteImages() -> [FavouriteImage] {
        var images: [FavouriteImage] = []
        do {
            images = try context.fetch(FavouriteImage.fetchRequest())
        }
        catch {
            print(CustomError.dataError.description)
        }
        return images.sorted { $0.newAddedDate > $1.newAddedDate }
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(CustomError.saveCoreData)
            }
        }
    }
    
    func addFavourite(_ imageData: Data, userQuery: String) {
        var images = fetchFavouriteImages()
        
        if let duplicateImage = images.first(where: { $0.userQuery == userQuery }) {
            removeFavourite(duplicateImage)
            images.removeAll { $0.userQuery == userQuery }
        }
        
        if images.count == picLimit, let lastImage = images.last {
            removeFavourite(lastImage)
        }
        
        let image = FavouriteImage(context: context)
        image.imageData = imageData
        image.userQuery = userQuery
        image.addedDate = Date()
        
        context.insert(image)
    }
    
    func removeFavourite(_ image: FavouriteImage) {
        context.delete(image)
    }
}
