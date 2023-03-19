//
//  Router.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showEdit(note: Note)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?

    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let listViewController = moduleBuilder?.createListModule(router: self) else { return }
            navigationController.viewControllers = [listViewController]
        }
    }

    func showEdit(note: Note) {
        if let navigationController = navigationController {
            guard let editViewController = moduleBuilder?.createEditModule(router: self, note: note) else { return }
            let navigation = UINavigationController(rootViewController: editViewController)
            navigationController.present(navigation, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
