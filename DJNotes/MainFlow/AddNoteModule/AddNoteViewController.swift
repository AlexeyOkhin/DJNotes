//
//  AddNoteViewController.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import UIKit

private enum Constants {
    static let standartPadding: CGFloat = 16
    static let cornerRadius: CGFloat  = 10
}

final class AddNoteViewController: UIViewController {

    //MARK: - Properties

    var presenter: AddNotePresenterProtocol!

    //MARK: - Private Properties

    lazy private var inputNoteTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemFill
        textView.layer.borderWidth = 0.3
        textView.font = .systemFont(ofSize: 17)
        textView.layer.cornerRadius = Constants.cornerRadius
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        inputNoteTextView.becomeFirstResponder()
    }
}

//MARK: -  Private Methods

private extension AddNoteViewController {

    func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .never

        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftButton

        let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
    }

    func configureView() {

        title = "DJNote"
        view.addSubview(inputNoteTextView)
        NSLayoutConstraint.activate([
            inputNoteTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.standartPadding*2),
            inputNoteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.standartPadding*2),
            inputNoteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.standartPadding*2),
            inputNoteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.standartPadding*2)

        ])
    }

    @objc
    func didTapCancel() {
        dismiss(animated: true)
    }

    @objc
    func didTapSave() {
        presenter.noteEdited(inputNoteTextView.text)
        dismiss(animated: true)
    }
}

// MARK: - Protocol methods

extension AddNoteViewController: AddNoteViewProtocol {
    func setNoteText(_ text: String) {
        inputNoteTextView.text = text
    }
}
