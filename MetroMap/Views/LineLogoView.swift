//
//  LineLogoView.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 21.11.24.
//

import UIKit

class LineLogoView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        backgroundColor = .blue
        self.layer.cornerRadius = 18
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
