//
//  SearchViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 22.11.24.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func originSelected(_ station: MetroStation)
    func destinationSelected(_ station: MetroStation)
}

class SearchViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate?
    
    private var isDestination = false
    
    public func configure(with isDestination: Bool) {
        self.isDestination = isDestination
    }
    
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
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
    
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isDestination {
            title = "Destination"
        } else {
            title = "Origin"
        }
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(StationTableViewCell.self, forCellReuseIdentifier: "StationCell")

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            
            magnifyingIcon.widthAnchor.constraint(equalToConstant: 20),
            doneButton.widthAnchor.constraint(equalToConstant: 60),
            
            searchField.heightAnchor.constraint(equalToConstant: 30),
            
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
    
    override func viewWillDisappear(_ animated: Bool) {
        searchField.resignFirstResponder()
    }

    @objc private func textChanged() {
        if let searchText = searchField.text {
            searchResults = metroNetwork.findStationsByName(searchText)
            
            tableView.reloadData()
        }
    }

    @objc func doneButtonTapped() {
        searchField.resignFirstResponder()
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
        let result = searchResults[indexPath.row]
        print("RES: \(result.name)")
        if isDestination {
            delegate?.destinationSelected(result)
        } else {
            delegate?.originSelected(result)
        }
        navigationController?.popViewController(animated: true)
    }
}
