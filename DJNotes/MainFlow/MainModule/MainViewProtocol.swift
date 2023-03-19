//
//  MainViewProtocol.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import Foundation

enum TableControl {
    case beginUpdates
    case endUpdates
    case reload
}

enum TableActions {
    case insert
    case delete
    case move
    case update
}

protocol MainViewProtocol: AnyObject {

    func updateTable(_ updateType: TableControl)
    func editTable(_ editingType: TableActions, indexPath: IndexPath?, newIndexPath: IndexPath?)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, dataManager: CoreDataManagerProtocol, router: RouterProtocol)

    func viewDidLoad()
    var result: [Note]? { get }
    func delete(_ note: Note)
    func search(_ query: String)
    func addNote()
    func editNote(_ note: Note)
}
