//
//  vc1.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 24.12.24.
//
import UIKit

class BottomSheetViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let rootVC = ContentViewController()
        let navigationController = UINavigationController(rootViewController: rootVC)

        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.view.frame = view.bounds
        navigationController.didMove(toParent: self)
    }
    
    @objc func pushNextScreen() {
        let nextVC = StationViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

class ContentViewController: UIViewController {
    
    private let originView = StationFieldView()
    private let destinationView = StationFieldView()
    
    private let swapImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.left.arrow.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sheetPresentationController?.selectedDetentIdentifier = UISheetPresentationController.Detent.Identifier("smallDetent")
    }
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)

        view.backgroundColor = .systemBackground
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(pushNextScreen))
        swapImageView.isUserInteractionEnabled = true
        swapImageView.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(searchStation))
        originView.isUserInteractionEnabled = true
        originView.addGestureRecognizer(tapGesture2)
        
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
    
    @objc func pushNextScreen() {
        print("pushed")
        let nextVC = StationViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func searchStation() {
        print("pushed search")
        let nextVC = SearchViewController()
//        sheetPresentationController?.selectedDetentIdentifier = UISheetPresentationController.Detent.Identifier("largeDetent")
        navigationController?.pushViewController(nextVC, animated: false)
        sheetPresentationController?.animateChanges {
            sheetPresentationController?.selectedDetentIdentifier = .large
        }

    }
}
