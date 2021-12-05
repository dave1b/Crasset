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
        self.getPortfolio()
        
    }
    
    func updatePortfolio(coin: String, amount: Float) {
        if let entity = portfolio.first(where: { $0.coinID == coin }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    func getAmountOfCoin(coin: String) -> Float {
        var amount: Float = 0.0
        if let entity = portfolio.first(where: { $0.coinID == coin }) {
            if entity.amount > 0 {
                amount = entity.amount
            }
            return amount
        }
        return amount
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<Asset>(entityName: entityName)
        do {
            portfolio = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func add(coin: String, amount: Float) {
        let entity = Asset(context: container.viewContext)
        entity.coinID = coin
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: Asset, amount: Float) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: Asset) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
