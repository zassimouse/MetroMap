//
//  CustomButton.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 30.01.25.
//

import UIKit

class CustomButton: UIView {
    
    enum CustomButtonType {
        case cancel
        case from
        case to
    }

    init(type: CustomButtonType) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 6
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        var systemName: String
        
        switch type {
        case .cancel:
            backgroundColor = .systemGray
            systemName = "xmark"
            label.text = "Cancel"
        case .from:
            backgroundColor = .systemBlue
            systemName = "arrow.down"
            label.text = "From"
        case .to:
            backgroundColor = .systemBlue
            systemName = "arrow.up"
            label.text = "To"
        }
        
        let image = UIImage(systemName: systemName)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
