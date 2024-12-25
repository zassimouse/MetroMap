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
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with lineNumber: Int) {
        label.text = "\(lineNumber)"
        switch lineNumber {
        case 1:
            backgroundColor = .metroBlue
        case 2:
            backgroundColor = .metroRed
        case 3:
            backgroundColor = .metroGreen
        default:
            backgroundColor = .gray
        }
    }
}
