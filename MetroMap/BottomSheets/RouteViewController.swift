//
//  vc1.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 24.12.24.
//
import UIKit

protocol RouteViewControllerDelegate: AnyObject {
    func searchOrigin()
    func searchDestination()
    func swapOriginDestination()
    func clearOrigin()
    func clearDestination()
    func originSelected(station: MetroStation)
    func destinationSelected(station: MetroStation)
}

class RouteViewController: UIViewController {
    
    weak var delegate: RouteViewControllerDelegate?
    
    private let originView = StationFieldView(isDestination: false)
    private let destinationView = StationFieldView(isDestination: true)
    
    private let swapImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.left.arrow.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setOriginStation(_ station: MetroStation) {
        originView.setStation(station)
    }
    
    func setDestinationStation(_ station: MetroStation) {
        destinationView.setStation(station)
    }
    
    func showStation(station: MetroStation) {
        let vc = StationViewController()
        vc.configure(with: station)
        vc.delegate = self
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromTop
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetPresentationController?.selectedDetentIdentifier = UISheetPresentationController.Detent.Identifier("smallDetent")
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        
        originView.delegate = self
        destinationView.delegate = self
        
        
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(swapOriginDestination))
        swapImageView.isUserInteractionEnabled = true
        swapImageView.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(searchOrigin))
        originView.isUserInteractionEnabled = true
        originView.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(searchDestination))
        destinationView.isUserInteractionEnabled = true
        destinationView.addGestureRecognizer(tapGesture3)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [originView, swapImageView, destinationView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.layer.cornerRadius = 8
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.heightAnchor.constraint(equalToConstant: 40),
            horizontalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            swapImageView.widthAnchor.constraint(equalToConstant: 20),
            destinationView.widthAnchor.constraint(equalTo: originView.widthAnchor),
        ])

        originView.translatesAutoresizingMaskIntoConstraints = false
        destinationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func searchOrigin() {
        delegate?.searchOrigin()
    }
    
    @objc func searchDestination() {
        delegate?.searchDestination()
    }
    
    @objc func swapOriginDestination() {
        delegate?.swapOriginDestination()
    }
}

extension RouteViewController: StationFieldViewDelegate {
    func clearOrigin() {
        delegate?.clearOrigin()
    }
    
    func clearDestination() {
        delegate?.clearDestination()
    }
}

extension RouteViewController: StationViewControllerDelegate {
    func originSelected(station: MetroStation) {
        delegate?.originSelected(station: station)
    }
    
    func destinationSelected(station: MetroStation) {
        delegate?.destinationSelected(station: station)
    }
    
    
}
