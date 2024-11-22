//
//  BottomSheetViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 20.11.24.
//

import UIKit

class RouteViewController: UIViewController {
    private let originView = OriginDestinationView()
    private let destinationView = OriginDestinationView()
    private let swapImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        swapImageView.image = UIImage(systemName: "arrow.left.arrow.right")
        swapImageView.contentMode = .scaleAspectFit
        swapImageView.tintColor = .systemGray

        let stackView = UIStackView(arrangedSubviews: [originView, destinationView, swapImageView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 44),

            swapImageView.widthAnchor.constraint(equalToConstant: 20),
        ])

        originView.translatesAutoresizingMaskIntoConstraints = false
        destinationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            originView.widthAnchor.constraint(equalTo: destinationView.widthAnchor)
        ])
    }
}
