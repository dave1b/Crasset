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
    private let entityName: String = "Portfolio"
    @Published var portfolio: [Portfolio] = []
    
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
        
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: "Portfolio")
        do {
            portfolio = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func add(coin: String, amount: Float) {
        let entity = Portfolio(context: container.viewContext)
        entity.coinID = coin
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: Portfolio, amount: Float) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: Portfolio) {
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
