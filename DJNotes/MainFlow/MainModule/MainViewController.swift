//
//  MainViewController.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Private Properties

    lazy var notesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }




}

