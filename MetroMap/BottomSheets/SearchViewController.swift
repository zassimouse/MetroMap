//
//  SearchViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 22.11.24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var metroNetwork = MetroNetwork()
    
    private var searchResults: [MetroStation] = []

    private let searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Origin"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        return textField
    }()
    
    private let magnifyingIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .gray
        return icon
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var stations: [MetroStation] = [
        MetroStation(number: 1, name: "Station 1", line: 1, travelTimeToNext: 3),
        MetroStation(number: 2, name: "Station 2", line: 2, travelTimeToNext: 4),
        MetroStation(number: 3, name: "Station 3", line: 3, travelTimeToNext: 5)
    ]
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .systemBackground
        
        
        // Setup the stack view
        stackView.addArrangedSubview(magnifyingIcon)
        stackView.addArrangedSubview(searchField)
        stackView.addArrangedSubview(doneButton)
        
//        view.addSubview(lineView)
        
        view.addSubview(stackView)
        view.addSubview(tableView)
        
        // Set the table view's data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register the custom table view cell
        tableView.register(StationTableViewCell.self, forCellReuseIdentifier: "StationCell")
//        view.bringSubviewToFront(stackView)

        NSLayoutConstraint.activate([
            // StackView constraints
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            
            // Set the height of the magnifying icon and done button to match the text field's height
            magnifyingIcon.widthAnchor.constraint(equalToConstant: 20),
            doneButton.widthAnchor.constraint(equalToConstant: 50),
            
            // Optional: Adjust searchField height to match desired value
            searchField.heightAnchor.constraint(equalToConstant: 30),
            
//            lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
//            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            
            // TableView constraints
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        searchField.becomeFirstResponder()
    }
    
    func configure(with metroNetwork: MetroNetwork) {
        self.metroNetwork = metroNetwork
    }

    @objc private func textChanged() {
        if let searchText = searchField.text {
            print("Search text: \(searchText)")
            
            searchResults = metroNetwork.findStationsByName(searchText)
            print(searchResults)
            searchResults.forEach { station in
                print(station.name)
            }
            
            tableView.reloadData()
        }
    }

    @objc private func doneButtonTapped() {
//         Dismiss the keyboard when Done is tapped
        searchField.resignFirstResponder()
        print("button tapped")
        
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationTableViewCell
        let station = searchResults[indexPath.row]
        cell.configure(with: station)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // close and call delegate
    }
}
