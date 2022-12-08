//
//  CoreDataProtocols.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import CoreData

protocol CoreDataManagerType {
    func getDataTask<T: NSManagedObject>(completion: @escaping (Result<[T]?, CoreDataError>) -> Void)
    func saveDataTask(data: DomainModel?, completion: @escaping (CoreDataError?) -> Void)
    func deleteDataTask(data: DomainModel?, completion: @escaping (CoreDataError?) -> Void)
}
