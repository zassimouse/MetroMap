//
//  BottomSheetViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 20.11.24.
//

import UIKit

class RouteViewController: UIViewController {
    
    private let originView = StationFieldView()
    private let destinationView = StationFieldView()
    
    private let swapImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.left.arrow.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(swap))
        swapImageView.isUserInteractionEnabled = true
        swapImageView.addGestureRecognizer(tapGesture)

        let horizontalStackView = UIStackView(arrangedSubviews: [originView, destinationView, swapImageView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.layer.cornerRadius = 8
        view.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: view.topAnchor),

            horizontalStackView.heightAnchor.constraint(equalToConstant: 44),
            swapImageView.widthAnchor.constraint(equalToConstant: 20),
            originView.widthAnchor.constraint(equalTo: destinationView.widthAnchor)
        ])

        originView.translatesAutoresizingMaskIntoConstraints = false
        destinationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func swap() {
        let station = MetroStation(number: 220, name: "Ploshcha Yakuba Kolasa", line: 1, travelTimeToNext: 6)
        originView.setStation(station)
        
        guard let sheet = sheetPresentationController else { return }
    }
}
