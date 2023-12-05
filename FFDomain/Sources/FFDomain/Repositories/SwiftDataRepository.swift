//
//  SwiftDataRepository.swift
//
//
//  Created by Dmytro Yantsybaiev on 07.11.2023.
//

import Combine
import SwiftData
import FFDataSource

public final class SwiftDataRepository: ObservableObject {

    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    public init() {
        do {
            let schema = Schema([
                Item.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            modelContext = modelContainer.mainContext
            modelContext.autosaveEnabled = true
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    public func insert(_ model: some PersistentModel) {
        modelContext.insert(model)
        try? modelContext.save()
    }

    public func delete(_ model: some PersistentModel) {
        modelContext.delete(model)
        try? modelContext.save()
    }

    public func fetch<Model: PersistentModel>(descriptor: FetchDescriptor<Model> = .init()) -> [Model]? {
        try? modelContext.fetch(descriptor)
    }
}
