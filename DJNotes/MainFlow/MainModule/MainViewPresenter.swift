//
//  MainViewPresenter.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import Foundation
import CoreData

final class MainViewPresenter: NSObject {

    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    private var dataManager: CoreDataManagerProtocol!
    private var fetchedResultsController: NSFetchedResultsController<Note>!

    var result: [Note]? {
        return self.fetchedResultsController.fetchedObjects
    }

    required init(view: MainViewProtocol, dataManager: CoreDataManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.dataManager = dataManager
    }

    // MARK: - Methods
    
    private func setupFetchedResultsController(filter: String? = nil) {
        fetchedResultsController = dataManager.createNotesFetchedResultsController(filter: filter)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }

    private func firstLaunchCheck() {
        let defaults = UserDefaults.standard

        if defaults.bool(forKey: "isFirstLaunch") == true {
            defaults.set(true, forKey: "isFirstLaunch")
        } else {
            let note = dataManager.createNote()
            note.text = "Hello, SHIFT!"
            note.lastUpdated = Date()
            dataManager.save()
            defaults.set(true, forKey: "isFirstLaunch")
        }
    }
}

// MARK: - Fetched Results Controller Delegate

extension MainViewPresenter: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.updateTable(.beginUpdates)
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            view?.editTable(.insert, indexPath: indexPath, newIndexPath: newIndexPath)
        case .delete:
            view?.editTable(.delete, indexPath: indexPath, newIndexPath: newIndexPath)
        case .move:
            view?.editTable(.move, indexPath: indexPath, newIndexPath: newIndexPath)
        case .update:
            view?.editTable(.update, indexPath: indexPath, newIndexPath: newIndexPath)
        @unknown default:
            view?.updateTable(.reload)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.updateTable(.endUpdates)
    }
}

// MARK: - Protocol Methods

extension MainViewPresenter: MainViewPresenterProtocol {
    func search(_ query: String) {
        if query.count >= 1 {
            setupFetchedResultsController(filter: query)
        } else{
            setupFetchedResultsController()
        }
        view?.updateTable(.reload)
    }

    func editNote(_ note: Note) {
        router?.showEdit(note: note)
    }

    func addNote() {
        let note = dataManager.createNote()
        router?.showEdit(note: note)
    }

    func delete(_ note: Note) {
        dataManager.deleteNote(note)
    }

    func viewDidLoad() {
        firstLaunchCheck()
        setupFetchedResultsController()
    }
}
