//
//  ModuleBuilder.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createListModule(router: RouterProtocol) -> UIViewController
    func createEditModule(router: RouterProtocol, note: Note) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {

    let coreDatadataManager = CoreDataManager(modelName: "DJNotes")

    func createListModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainViewPresenter(view: view, dataManager: coreDatadataManager, router: router)
        view.presenter = presenter
        return view
    }

    func createEditModule(router: RouterProtocol, note: Note) -> UIViewController {
        let view = AddNoteViewController()
        let presenter = AddNoteViewPresenter(view: view, dataManager: coreDatadataManager, router: router, note: note)
        view.presenter = presenter
        return view
    }
}
