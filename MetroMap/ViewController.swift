//
//  ViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 19.11.24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let metroNetwork = MetroNetwork()
    
    private var originStation: MetroStation? {
        didSet {
            print("TEST: \(originStation)")
        }
    }
    
    private var destinationStation: MetroStation?  {
        didSet {
            print("TEST: \(destinationStation)")
        }
    }

    // MARK: - Subviews
    let bottomSheet = BottomSheetViewController()
    private var scrollView: UIScrollView!
    private var mapView = MetroMapView()

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showRouteSheet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomSheet.delegate = self
        mapView.delegate = self
        
        
        setupUI()
    }
    
    // MARK: - SetupUI
    func setupUI() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
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
        
        mapView.contentMode = .redraw
        mapView.backgroundColor = .systemBackground
        mapView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mapView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: -200)
        ])
    }
    
    // MARK: - Methods
    func showRouteSheet() {
        guard view.window != nil else {
            print("⚠️ ViewController не в иерархии, откладываем показ BottomSheet.")
            return
        }
        
        if let sheetController = bottomSheet.sheetPresentationController {
            
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
            bottomSheet.isModalInPresentation = true
        }
        present(bottomSheet, animated: true)
    }
}

extension ViewController: SearchViewControllerDelegate {
    func originSelected(_ station: MetroStation) {
        bottomSheet.setOriginStation(station)
        originStation = station
        print("STATION SEL: \(station.name)")
    }
    
    func destinationSelected(_ station: MetroStation) {
        bottomSheet.setDestinationStation(station)
        destinationStation = station
        print("STATION SEL: \(station.name)")
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        mapView.setNeedsDisplay()
    }
}

extension ViewController: BottomSheetViewControllerDelegate {
    
    func destinationSelected(station: MetroStation) {
        destinationStation = station
        bottomSheet.setDestinationStation(station)
    }
    

    
    func originSelected(station: MetroStation) {
        originStation = station
        bottomSheet.setOriginStation(station)
    }
    
    func clearOrigin() {
        originStation = nil
    }
    
    func clearDestination() {
        destinationStation = nil
    }
    
    func searchOrigin() {
        print("DLG: Origin")
        dismiss(animated: false)
        let vc = SearchViewController()
        vc.configure(with: false)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchDestination() {
        print("DLG: Destination")
        dismiss(animated: false)
        let vc = SearchViewController()
        vc.configure(with: true)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func swapOriginDestination() {
        print("DLG: Swap")
        print("Origin \(originStation)")
        print("Destination \(destinationStation)")
        
        if let origin = originStation, let destination = destinationStation {
            self.originStation = destination
            self.destinationStation = origin
            
//            bottomSheet.setOriginStation(origin)
//            bottomSheet.setDestinationStation(destination)
        }
//        print ("Test swap: \(String(describing: originStation)) \(String(describing: destinationStation))")
        
        if let origin = originStation, let destination = destinationStation {
            bottomSheet.setOriginStation(origin)
            bottomSheet.setDestinationStation(destination)
        }
    }
}

extension ViewController: MetroMapViewDelegate {
    func didSelectStation(_ stationNumber: Int) {
        print("tapped \(stationNumber)")
        guard let s = metroNetwork.getStation(stationNumber) else { return }
        bottomSheet.showStation(station: s)
    }
}
