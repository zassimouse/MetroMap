//
//  Example.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 31.01.25.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let button = UIButton(type: .system)
        button.setTitle("Open Bottom Sheet", for: .normal)
        button.addTarget(self, action: #selector(openFirstBottomSheet), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    var firstSheet: FirstBottomSheetViewController!
    @objc func openFirstBottomSheet() {
        firstSheet = FirstBottomSheetViewController()
        firstSheet.modalPresentationStyle = .pageSheet
        if let sheet = firstSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // Custom height of 100 points
            sheet.prefersGrabberVisible = true
        }
        present(firstSheet, animated: true)
    }
}

// MARK: - First Bottom Sheet (100pt height)
class FirstBottomSheetViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let openButton = UIButton(type: .system)
        openButton.setTitle("Open Second Bottom Sheet", for: .normal)
        openButton.addTarget(self, action: #selector(openSecondBottomSheet), for: .touchUpInside)
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [openButton, closeButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func openSecondBottomSheet() {
        
        guard let sheet = sheetPresentationController else { return }

        sheet.animateChanges {
            sheet.selectedDetentIdentifier = .large
        }


            
        
        let secondSheet = SecondBottomSheetViewController()
        secondSheet.modalPresentationStyle = .overCurrentContext
        if let sheet = secondSheet.sheetPresentationController {
            sheet.detents = [.large()]  // Second sheet is large
            sheet.prefersGrabberVisible = true
        }
        present(secondSheet, animated: true)
        

    }
    
    @objc func closeSheet() {
        dismiss(animated: true)
    }
}

// MARK: - Second Bottom Sheet (Large)
class SecondBottomSheetViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        let label = UILabel()
        label.text = "This is the second (large) bottom sheet!"
        label.textAlignment = .center
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [label, closeButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func closeSheet() {
        dismiss(animated: true)
    }
}
