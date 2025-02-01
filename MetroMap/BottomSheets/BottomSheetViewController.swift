//
//  BottomSheetViewController.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 28.01.25.
//

import UIKit

protocol BottomSheetViewControllerDelegate: AnyObject {
    func searchOrigin()
    func searchDestination()
    func swapOriginDestination()
    func clearOrigin()
    func clearDestination()
    func originSelected(station: MetroStation)
    func destinationSelected(station: MetroStation)
}

class BottomSheetViewController: UIViewController {
    
    weak var delegate: BottomSheetViewControllerDelegate?

    private let rootVC = RouteViewController()
    private var navVC: UINavigationController!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        rootVC.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showStation(station: MetroStation) {
        rootVC.showStation(station: station)
//        navigationController?.popToRootViewController(animated: true)
//        navigationController?.topViewController.
//        let vc = StationViewController()
//        vc.configure(with: station)
        
        
        
//        navVC.topViewController?.showStation(station: station) 

    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navVC = UINavigationController(rootViewController: rootVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.view.frame = view.bounds
        navVC.didMove(toParent: self)
    }
    
    func setOriginStation(_ station: MetroStation) {
        rootVC.setOriginStation(station)
    }
    
    func setDestinationStation(_ station: MetroStation) {
        rootVC.setDestinationStation(station)
    }
}

extension BottomSheetViewController: RouteViewControllerDelegate {
    func originSelected(station: MetroStation) {
        delegate?.originSelected(station: station)
    }
    
    func destinationSelected(station: MetroStation) {
        delegate?.destinationSelected(station: station)
    }
    
    func clearOrigin() {
        delegate?.clearOrigin()
    }
    
    func clearDestination() {
        delegate?.clearDestination()
    }
    
    func searchOrigin() {
        delegate?.searchOrigin()
    }
    
    func searchDestination() {
        delegate?.searchDestination()
    }
    
    func swapOriginDestination() {
        delegate?.swapOriginDestination()
    }
}
