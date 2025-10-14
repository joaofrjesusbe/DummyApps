//
//  DummyJsonApp.swift
//  DummyJson
//
//  Created by Joao Jesus on 14/10/2025.
//

import SwiftUI
import CoreData

@main
struct DummyJsonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
