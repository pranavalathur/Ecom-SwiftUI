import SwiftUI

import SwiftUI
import CoreData
import Foundation

class HomeScreenViewModel: ObservableObject {
    @Published var sections: [Section] = []
    @Published var isLoading: Bool = true

    // Initialize Core Data Context
    private let context = CoreDataManager.shared.context

    func fetchDataAndStoreOffline() {
        guard let url = URL(string: "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            
            // Decode API response
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode([Section].self, from: data)
                
                // Save to Core Data
                self?.saveToCoreData(sections: response)
                
                DispatchQueue.main.async {
                    self?.sections = response
                    self?.isLoading = false
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }

    func saveToCoreData(sections: [Section]) {
        // Clear existing data in Core Data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SectionEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to delete old data: \(error)")
        }

        // Store new sections and their contents
        sections.forEach { [self] section in
            let sectionEntity = SectionEntity(context: context)
           // sectionEntity.id = UUID()
            sectionEntity.type = section.type
            sectionEntity.title = section.title

            section.contents?.forEach { content in
                let contentEntity = ContentEntity(context: context)
              //  contentEntity.id = UUID()
                contentEntity.title = content.title
                contentEntity.image_url = content.image_url
                contentEntity.actual_price = content.actual_price
                contentEntity.product_image = content.product_image

                // Establish relationship between section and content
                sectionEntity.addToContents(contentEntity)
            }
        }

        // Save Core Data context
        do {
            try context.save()
        } catch {
            print("Failed to save sections: \(error)")
        }
    }

    func fetchSectionsFromCoreData() {
        isLoading = false

        let request: NSFetchRequest<SectionEntity> = SectionEntity.fetchRequest()
        do {
            let sectionEntities = try context.fetch(request)
            
            // Convert Core Data entities back into the model format
            sections = sectionEntities.map { sectionEntity in
                Section(
                    id: sectionEntity.id ?? "0",
                    type: sectionEntity.type ?? "",
                    title: sectionEntity.title,
                    contents: sectionEntity.contents?.allObjects as? [Content]
                )
            }
        } catch {
            print("Failed to fetch sections from Core Data: \(error)")
        }
    }
}


struct Section: Codable, Identifiable {
    let id: String // Change from UUID to String
    let type: String
    let title: String?
    let contents: [Content]?
}

struct Content: Codable, Identifiable {
    let id: String? // Change from UUID to String
    let title: String?
    let image_url: String?
    let sku: String?
    let product_name: String?
    let product_image: String?
    let product_rating: Int?
    let actual_price: String?
    let offer_price: String?
    let discount: String?
}
