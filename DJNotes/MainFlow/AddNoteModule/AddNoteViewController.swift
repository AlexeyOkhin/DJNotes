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

    lazy private var editPanel = EditPanel()

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
        editPanel.delegate = self
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
        editPanel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editPanel)
        NSLayoutConstraint.activate([
            editPanel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.standartPadding*2),
            editPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.standartPadding*2),
            editPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.standartPadding*2),

            inputNoteTextView.topAnchor.constraint(equalTo: editPanel.bottomAnchor, constant: Constants.standartPadding*2),
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

//MARK: - EditPanelDelegate

extension AddNoteViewController: EditPanelDelegate {

    func didTappedIncrementFont() {
        guard let fontSize = inputNoteTextView.font?.pointSize else { return }

        inputNoteTextView.font = .systemFont(ofSize: fontSize + 1)

    }

    func didTappedDiscernment() {
        guard let fontSize = inputNoteTextView.font?.pointSize else { return }

        inputNoteTextView.font = .systemFont(ofSize: fontSize - 1)

    }

    func didTappedSetBold() {
        guard let fontSize = inputNoteTextView.font?.pointSize else { return }
        inputNoteTextView.font = .boldSystemFont(ofSize: fontSize)
    }

    func didTappedSetItalic() {

    }

    func didTappedSetUnderline() {

    }

    func didTappedSetInsertImage() {
        presentPhotoActionSheet()
    }
}

extension AddNoteViewController {

    //MARK: -  PhotoPicker Methods

    private func presentPhotoActionSheet() {
        let alert = UIAlertController()

        if UIImagePickerController.isSourceTypeAvailable(.camera) {

            alert.addAction(UIAlertAction(title: "Сделать фото", style: .default, handler: {[weak self] _ in
                self?.presentCamera()
            }))
        }

        alert.addAction(UIAlertAction(title: "Выбрать из галереи", style: .default, handler: {[weak self] _ in
            self?.presentPhotoPicker()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    private func presentCamera() {
        let presentVC = UIImagePickerController()
        presentVC.sourceType = .camera
        presentVC.delegate = self
        presentVC.allowsEditing = true
        present(presentVC, animated: true)
    }

    private func presentPhotoPicker() {
        let presentVC = UIImagePickerController()
        presentVC.sourceType = .photoLibrary
        presentVC.delegate = self
        presentVC.allowsEditing = true
        present(presentVC, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension AddNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true)

        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        let attachment = NSTextAttachment()
        attachment.image = selectedImage
        let newImageWidth = (inputNoteTextView.bounds.size.width - 20)
        let scale = newImageWidth/selectedImage.size.width
        let newImageHeight = selectedImage.size.height * scale

        attachment.bounds = CGRect.init(x: 0, y: 0, width: newImageWidth, height: newImageHeight)

        let attString = NSAttributedString(attachment: attachment)

        inputNoteTextView.textStorage.insert(attString, at: inputNoteTextView.selectedRange.location)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        picker.dismiss(animated: true)

    }
}
