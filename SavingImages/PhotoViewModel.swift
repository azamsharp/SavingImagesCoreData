//
//  PhotoViewModel.swift
//  SavingImages
//
//  Created by Mohammad Azam on 12/21/21.
//

import Foundation
import UIKit
import CoreData

class PhotoViewModel: ObservableObject {
    
    @Published var image: UIImage?
    private var context = CoreDataManager.shared.persistentContainer.viewContext
    
    
    init() {
        
        let request: NSFetchRequest<Photo> = NSFetchRequest(entityName: "Photo")
        
        do {
            let photos: [Photo] = try context.fetch(request)
            if let photo = photos.first {
                self.image = photo.content
            }
        } catch {
            print(error)
        }
        
    }
    
    func downloadImage() {
        
        let url = URL(string: "https://picsum.photos/200/300?id=\(UUID().uuidString)")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let photo = Photo(context: self.context)
            photo.title = "Random Photo"
            photo.content = UIImage(data: data)
            
            try? self.context.save()
            
            DispatchQueue.main.async {
                self.image = photo.content
            }
            
            
        }.resume()
        
    }
    
}
