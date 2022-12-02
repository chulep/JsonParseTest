//
//  CoreDataManager.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 15.11.2022.
//

import CoreData

class CoreDataManager {
    
    static let execute = CoreDataManager()
    
    private let coreDataStack = CoreDataStack()
    
    func getData(completion: @escaping (Result<[SavePicture], Error>) -> Void) {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavePicture> = SavePicture.fetchRequest()
        
        do {
            let data = try context.fetch(fetchRequest)
            completion(.success(data))
            print("ExportCoreData DONE")
        } catch {
            completion(.failure(error))
            print("ExportCoreData ERROR")
        }
    }
    
    func saveData(id: String?, urlFull: String?, urlSmall: String?, name: String?, description: String?, date: String?) {
        let context = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SavePicture", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context) as? SavePicture
        object?.idSave = id
        object?.nameSave = name
        object?.descriptionSave = description
        object?.dateSave = date
        object?.urlFullSave = urlFull
        object?.urlSmallSave = urlSmall
        
        do {
            try context.save()
            print("CoreDataSave DONE")
        } catch {
            print("CoreDataSave ERROR")
        }
    }
    
    func deleteData(id: String?) {
        guard let id = id else { return }
        var allRecipe = [SavePicture]()
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
    
    private func search(id: String, allData: [SavePicture]) -> SavePicture {
        return allData.filter({ return String($0.idSave ?? "").lowercased().contains(id.lowercased()) })[0]
    }
    
    func getDataT<T: NSManagedObject>(completion: @escaping (Result<[T]?, Error>) -> Void) {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest = T.fetchRequest()
        
        do {
            let data = try context.fetch(fetchRequest) as? [T]
            completion(.success(data))
            print("ExportCoreData DONE")
        } catch {
            completion(.failure(error))
            print("ExportCoreData ERROR")
        }
    }
}
