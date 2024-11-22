//
//  ViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 19.11.24.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, MetroMapViewDelegate {
    
    func didSelectStation(_ sender: MetroMapView) {
        showStationSheet()
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
    func showStationSheet() {
        dismiss(animated: true)
        
        let controller = StationViewController()
        
        if let sheetController = controller.sheetPresentationController {
            
            let smallDetent = UISheetPresentationController.Detent.custom(
                identifier: UISheetPresentationController.Detent.Identifier("smallDetent"),
                resolver: { _ in
                    return 150 - self.view.safeAreaInsets.bottom
                }
            )
            
            sheetController.detents = [smallDetent]
            sheetController.prefersGrabberVisible = true
            sheetController.largestUndimmedDetentIdentifier = UISheetPresentationController.Detent.Identifier("smallDetent")
            
            controller.isModalInPresentation = true
        }
        
        present(controller, animated: true)
    }
    
    func showRouteSheet() {
        let controller = RouteViewController()
        
        if let sheetController = controller.sheetPresentationController {
            
            let smallDetent = UISheetPresentationController.Detent.custom(
                identifier: UISheetPresentationController.Detent.Identifier("smallDetent"),
                resolver: { _ in
                    return 100 - self.view.safeAreaInsets.bottom
                }
            )
            
            sheetController.detents = [smallDetent]
            sheetController.prefersGrabberVisible = true
            sheetController.largestUndimmedDetentIdentifier = UISheetPresentationController.Detent.Identifier("smallDetent")
            
            controller.isModalInPresentation = true
        }
        
        present(controller, animated: true)
    }
}
