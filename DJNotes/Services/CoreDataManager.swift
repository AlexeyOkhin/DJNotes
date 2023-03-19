//
//  CoreDataManager.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func save()
    func createNote() -> Note
    func deleteNote(_ note: Note)
    func createNotesFetchedResultsController(filter: String?) -> NSFetchedResultsController<Note>
}

class CoreDataManager: CoreDataManagerProtocol {

    private let persistentContainer: NSPersistentContainer
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init(modelName: String) {
        self.persistentContainer = NSPersistentContainer(name: modelName)
        load()
    }

    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }

    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("with saving: \(error.localizedDescription)")
            }
        }
    }

    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.id = UUID()
        note.text = ""
        note.lastUpdated = Date()
        save()
        return note
    }

    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }

    func createNotesFetchedResultsController(filter: String? = nil) -> NSFetchedResultsController<Note> {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]

        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: viewContext,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
}
