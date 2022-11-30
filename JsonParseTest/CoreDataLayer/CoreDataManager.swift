//
//  CoreDataManager.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 15.11.2022.
//

import CoreData

class CoreDataManager {
    
    func getData(completion: @escaping (Result<[Model], Error>) -> Void) {
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavePicture> = SavePicture.fetchRequest()
        
        do {
            let data = try context.fetch(fetchRequest)
            completion(.success(data.map { $0.domain } ))
            print("ExportCoreData DONE")
        } catch {
            completion(.failure(error))
            print("ExportCoreData ERROR")
        }
    }
    
    func saveData(id: String?, url: String?, name: String?, description: String?, date: String?, image: Data?) {
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RecipeData", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context) as? SavePicture
        object?.idSave = id
        object?.nameSave = name
        object?.descriptionSave = description
        object?.dateSave = date
        object?.urlSave = url
        object?.imageSave = image
        
        do {
            try context.save()
            print("CoreDataSave DONE")
        } catch {
            print("CoreDataSave ERROR")
        }
    }
    
    func deleteData(id: String) {
        var allRecipe = [SavePicture]()
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavePicture> = SavePicture.fetchRequest()
        
        do {
            allRecipe = try context.fetch(fetchRequest)
            context.delete(search(id: id, allData: allRecipe))
            try context.save()
            print("CoreDataDelete DONE")
        } catch {
            print("CoreDataDelete ERROR")
        }
    }
    
    func search(id: String, allData: [SavePicture]) -> SavePicture {
        return allData.filter({ return String($0.idSave ?? "").lowercased().contains(id.lowercased()) })[0]
    }
    
}
