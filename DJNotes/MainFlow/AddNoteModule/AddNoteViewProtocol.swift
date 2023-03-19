//
//  AddNoteViewProtocol.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import Foundation

protocol AddNoteViewProtocol: AnyObject {

    func setNoteText(_ text: String)

}

protocol AddNotePresenterProtocol: AnyObject {
    init(view: AddNoteViewProtocol, dataManager: CoreDataManagerProtocol, router: RouterProtocol, note: Note)

    func noteEdited(_ text: String)

}
