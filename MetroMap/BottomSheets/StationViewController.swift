//
//  StationViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 21.11.24.
//

import UIKit

protocol StationViewControllerDelegate: AnyObject {
    func originSelected(station: MetroStation)
    func destinationSelected(station: MetroStation)
}

class StationViewController: UIViewController {
    
    weak var delegate: StationViewControllerDelegate?
    
    private var station: MetroStation!
    
    private var lineLogoView = LineLogoView()
    
    private let stationNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let intervalLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Interval is 7 min"
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .label
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let workingHoursLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Open 7:00 to 00:40"
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .label
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
//    private let stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 4
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    
//    private let cancelButton: UIButton = {
//        let button = UIButton()
//        
//        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
//        let image = UIImage(systemName: "xmark")?.applyingSymbolConfiguration(boldConfig)?.withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
//        
//        button.setTitle("Cancel", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
//
//        button.backgroundColor = .systemBlue
//        button.layer.cornerRadius = 5
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private let cancelButton = CustomButton(type: .cancel)
    private let fromButton = CustomButton(type: .from)
    private let toButton = CustomButton(type: .to)
    
//    private let fromButton: UIButton = {
//        let button = UIButton()
//        
//        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
//        let image = UIImage(systemName: "arrow.down")?.applyingSymbolConfiguration(boldConfig)?.withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
//        
//        button.setTitle("From", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
//
//        button.backgroundColor = .systemBlue
//        button.layer.cornerRadius = 5
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
//    private let toButton: UIButton = {
//        let button = UIButton()
//        
//        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
//        let image = UIImage(systemName: "arrow.up")?.applyingSymbolConfiguration(boldConfig)?.withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
//        
//        button.setTitle("To", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
//
//        button.backgroundColor = .systemBlue
//        button.layer.cornerRadius = 5
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configure(with station: MetroStation) {
        print("configured with \(station.name)")
        stationNameLabel.text = station.name
        lineLogoView.configure(with: station)
        self.station = station
    }
    
    func showStation(station: MetroStation) {
        let vc = StationViewController()
        vc.configure(with: station)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func popToRoot() {
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromTop
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func fromButtonTapped() {
        delegate?.originSelected(station: station)
        popToRoot()
    }
    
    @objc func toButtonTapped() {
        delegate?.destinationSelected(station: station)
        popToRoot()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(lineLogoView)
        view.addSubview(stationNameLabel)
        
        NSLayoutConstraint.activate([
            lineLogoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lineLogoView.widthAnchor.constraint(equalToConstant: 40),
            lineLogoView.heightAnchor.constraint(equalToConstant: 30),
            lineLogoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            
            stationNameLabel.leadingAnchor.constraint(equalTo: lineLogoView.trailingAnchor, constant: 10),
            stationNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
        ])
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(popToRoot))
        cancelButton.isUserInteractionEnabled = true
        cancelButton.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(fromButtonTapped))
        fromButton.isUserInteractionEnabled = true
        fromButton.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(toButtonTapped))
        toButton.isUserInteractionEnabled = true
        toButton.addGestureRecognizer(tapGesture3)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [cancelButton, fromButton, toButton])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 4
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.heightAnchor.constraint(equalToConstant: 50),
            horizontalStackView.topAnchor.constraint(equalTo: lineLogoView.bottomAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
                

    }
}
