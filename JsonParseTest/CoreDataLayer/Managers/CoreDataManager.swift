//
//  CoreDataManager.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 15.11.2022.
//

import CoreData

class CoreDataManager: CoreDataManagerType {
    
    static let execute = CoreDataManager()
    private let coreDataStack = CoreDataStack()
    
    func getDataTask<T: NSManagedObject>(completion: @escaping (Result<[T]?, CoreDataError>) -> Void) {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest = T.fetchRequest()
        
        do {
            let data = try context.fetch(fetchRequest) as? [T]
            completion(.success(data))
            print("ExportCoreData DONE")
        } catch {
            completion(.failure(CoreDataError.fetchFailed))
            print("ExportCoreData ERROR")
        }
    }
    
    func saveDataTask(data: DomainResultModel?, completion: @escaping (CoreDataError?) -> Void) {
        guard let data = data else { return completion(CoreDataError.saveFailed) }
        let context = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SavePicture", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context) as? SavePicture
        object?.idSave = data.id
        object?.nameSave = data.name
        object?.descriptionSave = data.description
        object?.dateSave = data.date
        object?.urlFullSave = data.imageUrlFull
        object?.urlSmallSave = data.imageUrlSmall
        
        do {
            try context.save()
            completion(nil)
            print("CoreDataSave DONE")
        } catch {
            completion(CoreDataError.saveFailed)
            print("CoreDataSave ERROR")
        }
    }
    
    func deleteDataTask(data: DomainResultModel?, completion: @escaping (CoreDataError?) -> Void) {
        guard let id = data?.id else { return completion(CoreDataError.deleteFailed)}
        var allRecipe = [SavePicture]()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavePicture> = SavePicture.fetchRequest()
        
        do {
            allRecipe = try context.fetch(fetchRequest)
            context.delete(search(id: id, allData: allRecipe))
            try context.save()
            print("CoreDataDelete DONE")
        } catch {
            completion(CoreDataError.deleteFailed)
            print("CoreDataDelete ERROR")
        }
    }
    
    //supports deleteDataTask
    private func search(id: String, allData: [SavePicture]) -> SavePicture {
        return allData.filter({ return String($0.idSave ?? "").lowercased().contains(id.lowercased()) })[0]
    }
}
