//
//  EditPanel.swift
//  DJNotes
//
//  Created by Djinsolobzik on 23.03.2023.
//

import UIKit

private enum Constants {
    static let standardPadding: CGFloat = 8
    static let buttonHeight: CGFloat = 35
}

final class EditPanel: UIView {

    lazy var incrementFontSizeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()

    lazy var discernmentFontSizeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        return button
    }()

    lazy var boldFontButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bold"), for: .normal)
        return button
    }()

    lazy var cursiveFontButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "italic"), for: .normal)
        return button
    }()

    lazy var normalFontButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "underline"), for: .normal)
        return button
    }()

    lazy var insertImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "photo.on.rectangle"), for: .normal)
        return button
    }()

    lazy var fontLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let labelFont = label.font.pointSize
        label.text = "\(labelFont) - Font"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupConstraints() {
        addSubview(incrementFontSizeButton)
        addSubview(fontLabel)
        addSubview(discernmentFontSizeButton)
//        addSubview(boldFontButton)
//        addSubview(cursiveFontButton)
//        addSubview(normalFontButton)
        addSubview(insertImageButton)

        let stackView = UIStackView(arrangedSubviews: [boldFontButton, cursiveFontButton, normalFontButton])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally

        addSubview(stackView)
        fontLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate([
            discernmentFontSizeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            discernmentFontSizeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            discernmentFontSizeButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            discernmentFontSizeButton.widthAnchor.constraint(equalToConstant: Constants.buttonHeight),

            fontLabel.leadingAnchor.constraint(equalTo: discernmentFontSizeButton.trailingAnchor, constant: Constants.standardPadding),
            fontLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            incrementFontSizeButton.leadingAnchor.constraint(equalTo: fontLabel.trailingAnchor, constant: Constants.standardPadding),
            incrementFontSizeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            incrementFontSizeButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            incrementFontSizeButton.widthAnchor.constraint(equalToConstant: Constants.buttonHeight),

            stackView.leadingAnchor.constraint(equalTo: incrementFontSizeButton.trailingAnchor, constant: Constants.standardPadding),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            insertImageButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Constants.standardPadding),
            insertImageButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            insertImageButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            insertImageButton.widthAnchor.constraint(equalToConstant: Constants.buttonHeight),
            insertImageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
