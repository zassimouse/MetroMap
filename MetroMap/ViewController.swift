//
//  ViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 19.11.24.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, MetroMapViewDelegate {
    
    private let metroNetwork = MetroNetwork()
    
    func didSelectStation(_ station: Int) {
        print("tapped \(station)")
    }
    
    private var scrollView: UIScrollView!
    private var mapView = MetroMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.delegate = self
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 1.0
        scrollView.isUserInteractionEnabled = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        mapView.delegate = self
        mapView.contentMode = .redraw
        mapView.backgroundColor = .systemBackground
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mapView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        mapView.setNeedsDisplay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showRouteSheet()
    }
}


extension ViewController {
    
    func showRouteSheet() {
        let controller = BottomSheetViewController()
        
        if let sheetController = controller.sheetPresentationController {
            
            let smallDetent = UISheetPresentationController.Detent.custom(
                identifier: .init("smallDetent"),
                resolver: { _ in
                    return 120 - self.view.safeAreaInsets.bottom
                }
            )
            
            let largeDetent = UISheetPresentationController.Detent.custom(
                identifier: UISheetPresentationController.Detent.Identifier("largeDetent"),
                resolver: { _ in
                    return self.view.frame.height - self.view.safeAreaInsets.bottom - self.view.safeAreaInsets.top - 50
                }
            )
            
            sheetController.detents = [smallDetent, largeDetent, .large()]
            
            sheetController.prefersGrabberVisible = true 
            sheetController.largestUndimmedDetentIdentifier = .init("largeDetent")
            controller.isModalInPresentation = true
        }
        
        present(controller, animated: true)
    }
}
