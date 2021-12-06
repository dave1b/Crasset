//
//  CrassetApp.swift
//  Crasset
//
//  Created by Dave Brunner on 17.11.21.
//

import SwiftUI

@main
struct CrassetApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var coinCoreDatService = CoinCoreDataService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(coinCoreDatService)
        }
    }
}
