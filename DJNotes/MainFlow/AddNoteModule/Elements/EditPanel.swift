//
//  EditPanel.swift
//  DJNotes
//
//  Created by Djinsolobzik on 23.03.2023.
//

import UIKit

protocol EditPanelDelegate: AnyObject {
    func didTappedIncrementFont()
    func didTappedDiscernment()
    func didTappedSetBold()
    func didTappedSetItalic()
    func didTappedSetFont()
    func didTappedSetInsertImage()
}

private enum Constants {
    static let standardPadding: CGFloat = 8
    static let buttonHeight: CGFloat = 35
}

final class EditPanel: UIView {

    weak var delegate: EditPanelDelegate?

    private var currentSizeFont = 17

    lazy var incrementFontSizeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(tapIncrement), for: .touchUpInside)
        return button
    }()

    lazy var discernmentFontSizeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(tapDiscernment), for: .touchUpInside)
        return button
    }()

    lazy var boldFontButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bold"), for: .normal)
        button.addTarget(self, action: #selector(tapSetBoldFont), for: .touchUpInside)
        return button
    }()

    lazy var cursiveFontButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "italic"), for: .normal)
        button.addTarget(self, action: #selector(tapSetItalicFont), for: .touchUpInside)
        return button
    }()

    lazy var changeFontButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "character.hi"), for: .normal)
        button.addTarget(self, action: #selector(tapChangeFont), for: .touchUpInside)
        return button
    }()

    lazy var insertImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "photo.on.rectangle"), for: .normal)
        button.addTarget(self, action: #selector(tapInsertImage), for: .touchUpInside)
        return button
    }()

    lazy var fontLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let labelFont = label.font.pointSize
        label.text = "\(currentSizeFont) - Font"
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
        addSubview(insertImageButton)

        let stackView = UIStackView(arrangedSubviews: [boldFontButton, cursiveFontButton, changeFontButton])
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

    @objc
    private func tapIncrement() {
        if currentSizeFont < 36 {
            currentSizeFont += 1
            fontLabel.text = "\(currentSizeFont) - Font"
            delegate?.didTappedIncrementFont()
        }
    }

    @objc
    private func tapDiscernment() {
        if currentSizeFont > 8 {
            currentSizeFont -= 1
            fontLabel.text = "\(currentSizeFont) - Font"
            delegate?.didTappedDiscernment()
        }
    }

    @objc
    private func tapSetBoldFont() {
        delegate?.didTappedSetBold()
    }

    @objc
    private func tapSetItalicFont() {
        delegate?.didTappedSetItalic()
    }

    @objc
    private func tapChangeFont() {
        delegate?.didTappedSetFont()
    }

    @objc
    private func tapInsertImage() {
        delegate?.didTappedSetInsertImage()
    }

}
