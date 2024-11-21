//
//  StationViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 21.11.24.
//

import UIKit

class StationViewController: UIViewController {
    
    private var lineLogoView = LineLogoView()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Ploshcha Yakuba Kolasa"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextTrainLabel1: UILabel = {
        let label = UILabel()
        label.text = "Next train to Ploshcha Peramohi in 2 min"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workingHoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Open 7:00 to 00:40"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextTrainLabel2: UILabel = {
        let label = UILabel()
        label.text = "Next train to Akademija Navuk in 2 min"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let fromButton: UIButton = {
        let button = UIButton()
        button.setTitle("From", for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let toButton: UIButton = {
        let button = UIButton()
        button.setTitle("To", for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(lineLogoView)
        view.addSubview(label)
        view.addSubview(stackView)

        
        stackView.addArrangedSubview(nextTrainLabel1)
        stackView.addArrangedSubview(nextTrainLabel2)
        stackView.addArrangedSubview(workingHoursLabel)

        view.addSubview(fromButton)
        view.addSubview(toButton)
        
        
        NSLayoutConstraint.activate([
            lineLogoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineLogoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            lineLogoView.widthAnchor.constraint(equalToConstant: 36),
            lineLogoView.heightAnchor.constraint(equalToConstant: 36),
            
            label.leadingAnchor.constraint(equalTo: lineLogoView.trailingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 36),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: lineLogoView.bottomAnchor, constant: 20),
            
            fromButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fromButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            fromButton.heightAnchor.constraint(equalToConstant: 36),
            fromButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -2),
            
            toButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            toButton.heightAnchor.constraint(equalToConstant: 36),
            toButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 2),
        ])
    }
}
