//
//  OriginDestinationViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 20.11.24.
//

import UIKit

protocol StationFieldViewDelegate: AnyObject {
    func clearOrigin()
    func clearDestination()
}

class StationFieldView: UIView {
    // MARK: - Properties
    weak var delegate: StationFieldViewDelegate?
    private var isDestination: Bool = false
    private var placeholder: String {
        if isDestination {
            return "To"
        } else {
            return "From"
        }
    }
    
    // MARK: - Subviews
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryLabel
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    init(isDestination: Bool) {
        super.init(frame: .zero)
        self.isDestination = isDestination
        label.text = placeholder
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    func setupUI() {
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 8
        
        clearButton.addTarget(self, action: #selector(clearStation), for: .touchUpInside)
        
        self.addSubview(label)
        self.addSubview(clearButton)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -25),
            
            clearButton.widthAnchor.constraint(equalToConstant: 20),
            clearButton.heightAnchor.constraint(equalToConstant: 20),
            clearButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Methods
    func setStation(_ station: MetroStation) {
        label.text = station.name
        label.textColor = .label
        clearButton.isHidden = false
    }
    
    // MARK: - Selectors
    @objc func clearStation() {
        print("Field View(clearStation): Clear station")
        label.text = placeholder
        label.textColor = .secondaryLabel
        clearButton.isHidden = true
        
        if isDestination {
            delegate?.clearDestination()
        } else {
            delegate?.clearOrigin()
        }
    }
}
