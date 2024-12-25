//
//  OriginDestinationViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 20.11.24.
//

import UIKit

class StationFieldView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "From"
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

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 8
        
        clearButton.addTarget(self, action: #selector(clearStation), for: .touchUpInside)
        
        self.addSubview(label)
        self.addSubview(clearButton)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            
            clearButton.widthAnchor.constraint(equalToConstant: 20),
            clearButton.heightAnchor.constraint(equalToConstant: 20),
            clearButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStation(_ station: MetroStation) {
        label.text = station.name
        label.textColor = .label
        clearButton.isHidden = false
    }
    
    @objc func clearStation() {
        label.text = "From"
        label.textColor = .secondaryLabel
        clearButton.isHidden = true
    }
}
