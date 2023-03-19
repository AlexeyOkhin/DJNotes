//
//  AddNoteViewPresenter.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import Foundation

final class AddNoteViewPresenter {

    weak var view: AddNoteViewProtocol?
    var router: RouterProtocol?
    let dataManager: CoreDataManagerProtocol!
    var note: Note!

    required init(view: AddNoteViewProtocol, dataManager: CoreDataManagerProtocol, router: RouterProtocol, note: Note) {
        self.view = view
        self.dataManager = dataManager
        self.router = router
        self.note = note
        view.setNoteText(note.text)
    }
}

extension AddNoteViewPresenter: AddNotePresenterProtocol {
    func noteEdited(_ text: String) {
        note.text = text
        if note.title.isEmpty != true {
            note.lastUpdated = Date()
            dataManager.save()
        } else {
            dataManager.deleteNote(note)
        }
    }
}
