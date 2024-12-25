//
//  StationViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 21.11.24.
//

import UIKit

class StationViewController: UIViewController {

    private var lineLogoView = LineLogoView()
    
    private let sattionNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ploshcha Yakuba Kolasa"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let intervalLabel: UILabel = {
        let label = UILabel()
        label.text = "Interval is 7 min"
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let fromButton: UIButton = {
        let button = UIButton()
        button.setTitle("From", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let toButton: UIButton = {
        let button = UIButton()
        button.setTitle("To", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Kamennaja Horka"
        
        lineLogoView.configure(with: 2)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: lineLogoView)

        view.addSubview(fromButton)
        view.addSubview(toButton)
                
        NSLayoutConstraint.activate([

            lineLogoView.widthAnchor.constraint(equalToConstant: 30),
            lineLogoView.heightAnchor.constraint(equalToConstant: 30),
            
            fromButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            fromButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fromButton.heightAnchor.constraint(equalToConstant: 40),
            fromButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -2),
            
            toButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            toButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 2),
            toButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
