//
//  CoinCoreDataService.swift
//  Crasset
//
//  Created by daniele Muheim on 30.11.21.
//

import Foundation
import CoreData

class CoinCoreDataService : ObservableObject {
    
    private let container: NSPersistentContainer
    private let containerName: String = "Crasset"
    private let entityName: String = "Asset"
    @Published var portfolio: [Asset] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        }
        self.getAssets()
    }
    
    func updateAssets(cryptoID: String, amount: Float) {
        if let entity = portfolio.first(where: { $0.cryptoID == cryptoID }) {
            if amount > 0 {
                updateAsset(entity: entity, amount: amount)
            } else {
                deleteAsset(entity: entity)
            }
        } else {
            addCoinToAssets(cryptoID: cryptoID, amount: amount)
        }
    }
    
    func getAmountOfCoin(cryptoID: String) -> Float {
        var amount: Float = 0.0
        if let entity = portfolio.first(where: { $0.cryptoID == cryptoID }) {
            if entity.amount > 0 {
                amount = entity.amount
            }
            return amount
        }
        return amount
    }
    
    private func getAssets() {
        let request = NSFetchRequest<Asset>(entityName: entityName)
        do {
            portfolio = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func addCoinToAssets(cryptoID: String, amount: Float) {
        let entity = Asset(context: container.viewContext)
        entity.cryptoID = cryptoID
        entity.amount = amount
        applyChanges()
    }
    
    private func updateAsset(entity: Asset, amount: Float) {
        entity.amount = amount
        applyChanges()
    }
    
    private func deleteAsset(entity: Asset) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    private func saveAsset() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        saveAsset()
        getAssets()
    }
}
