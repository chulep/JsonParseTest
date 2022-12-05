//
//  CoreDataProtocols.swift
//  JsonParseTest
//
//  Created by Pavel Schulepov on 05.12.2022.
//

import CoreData

protocol CoreDataManagerType {
    func getDataTask<T: NSManagedObject>(completion: @escaping (Result<[T]?, Error>) -> Void)
    func saveDataTask(data: DomainModel?)
    func deleteDataTask(data: DomainModel?)
}
