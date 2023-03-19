//
//  NoteTableViewCell.swift
//  DJNotes
//
//  Created by Djinsolobzik on 19.03.2023.
//

import UIKit

private enum Constants {
    static let standartPadding: CGFloat = 16
}

class NoteTableViewCell: UITableViewCell {

    //MARK: -  Static Properties

    static let identifier = "\(NoteTableViewCell.self)"

    //MARK: - Private Properties

    private var titleNote: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()

    private var descriptionNote: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .placeholderText
        return label
    }()

    //MARK: - LifeCycle Cell

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleNote.text = nil
        descriptionNote.text = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private Methods

    private func setConstraints() {
        contentView.addSubview(titleNote)
        contentView.addSubview(descriptionNote)

        NSLayoutConstraint.activate([
            titleNote.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.standartPadding/2),
            titleNote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.standartPadding/2),
            titleNote.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.standartPadding/2),


            descriptionNote.topAnchor.constraint(equalTo: titleNote.bottomAnchor, constant: Constants.standartPadding),
            descriptionNote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.standartPadding/2),
            descriptionNote.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.standartPadding/2),
            descriptionNote.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.standartPadding/2)
        ])
    }
}

//MARK: - Extension Methods

extension NoteTableViewCell {

    func configure(note: Note) {
        titleNote.text = note.title
        descriptionNote.text = note.desc
    }
}
