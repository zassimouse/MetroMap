//
//  ViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 19.11.24.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    private var scrollView: UIScrollView!
    private var mapView = MetroMapView(frame: CGRect(origin: .zero, size: CGSize(width: 2000, height: 2000)))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 1.0

        scrollView.isUserInteractionEnabled = true
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(mapView)
        
        scrollView.contentSize = mapView.bounds.size

        
        // Set constraints for scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Set constraints for mapView
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mapView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        mapView.contentMode = .redraw
        
        mapView.backgroundColor = .systemBackground
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        mapView.setNeedsDisplay()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let controller = StationViewController()
        
        if let sheetController = controller.sheetPresentationController {
            
            let smallDetent = UISheetPresentationController.Detent.custom(
                identifier: UISheetPresentationController.Detent.Identifier("smallDetent"),
                resolver: { _ in
                    return 220 - self.view.safeAreaInsets.bottom
                }
            )
            
            sheetController.detents = [smallDetent] // Apply the custom detent
            sheetController.prefersGrabberVisible = true // Show the grabber
            sheetController.largestUndimmedDetentIdentifier = UISheetPresentationController.Detent.Identifier("smallDetent") // Prevent background dimming
            
            controller.isModalInPresentation = true
        }
        
        present(controller, animated: true)
    }
}
