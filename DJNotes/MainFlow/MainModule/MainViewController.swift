//
//  MainViewController.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: - Properties

    var presenter: MainViewPresenterProtocol!

    //MARK: - Private Properties

    lazy private var notesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupConstraints()
        configureNavigationBar()
        configureTableView()
        presenter.viewDidLoad()
    }
}

//MARK: -  Private Methods

private extension MainViewController {

    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "DJNotes"

        let addNoteButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(didTapAddNote))
        navigationItem.rightBarButtonItem = addNoteButton
    }

    func setupConstraints() {

        view.addSubview(notesTableView)

        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func configureTableView() {
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.showsVerticalScrollIndicator = false
        notesTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
    }

    @objc
    func didTapAddNote() {
        presenter.addNote()
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.result?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier,
                                                       for: indexPath)
                as? NoteTableViewCell,
                let note = presenter.result?[indexPath.row]
                else { return UITableViewCell() }

        cell.configure(note: note)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let note = presenter.result?[indexPath.row] else { return }
            presenter.delete(note)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let note = presenter.result?[indexPath.row] else { return }
        presenter.editNote(note)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Protocol methods
extension MainViewController: MainViewProtocol {
    func updateTable(_ updateType: TableControl) {
        switch updateType {
        case .beginUpdates:
            notesTableView.beginUpdates()
        case .endUpdates:
            notesTableView.endUpdates()
        case .reload:
            notesTableView.reloadData()
        }
    }

    func editTable(_ editingType: TableActions, indexPath: IndexPath?, newIndexPath: IndexPath?) {
        switch editingType {
        case .insert:
            notesTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            notesTableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            notesTableView.moveRow(at: indexPath!, to: newIndexPath!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.notesTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        case .update:
            notesTableView.reloadRows(at: [indexPath!], with: .automatic)
        }
    }
}



