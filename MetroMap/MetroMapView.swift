//
//  MapView.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 19.11.24.
//

import UIKit

protocol MetroMapViewDelegate: AnyObject {
    func didSelectStation(_ sender: MetroMapView)
}


class MetroMapView: UIView {
    
    weak var delegate: MetroMapViewDelegate?
    
    private lazy var offsetY: CGFloat = {
        let contentSize: CGFloat = 630
        
        let viewBounds = self.bounds
        
        let scaleWidth = viewBounds.width / contentSize
        let scaleHeight = viewBounds.height / contentSize
        
        let scaleFactor = min(scaleWidth, scaleHeight)
        
        let resizedSize = contentSize * scaleFactor
        
        let offsetY = (viewBounds.height - resizedSize) / 2.0
        return offsetY
    }()
    
    override class var layerClass: AnyClass {
        return CATiledLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        if let tiledLayer = self.layer as? CATiledLayer {
            tiledLayer.levelsOfDetail = 2
            tiledLayer.levelsOfDetailBias = 1
            tiledLayer.tileSize = CGSize(width: 500, height: 500)
        }
        self.backgroundColor = .systemBackground
        setupGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Save the current context state
        context.saveGState()

        // Clip the drawing to the current tile
        context.clip(to: rect)

        // Draw the full content, but only visible parts will be rendered
        StyleKit.drawCanvas1(frame: self.bounds, resizing: .aspectFit)

        // Restore the context state
        context.restoreGState()
    }
    
    
    private func setupGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        // Get tap location in the view's coordinate system
        let tapLocation = gesture.location(in: self)
        
        // Calculate the scaled coordinates based on the content scaling
        let contentSize: CGFloat = 630
        let viewBounds = self.bounds
        
        // Calculate the scale factor (aspectFit)
        let scaleWidth = viewBounds.width / contentSize
        let scaleHeight = viewBounds.height / contentSize
        let scaleFactor = min(scaleWidth, scaleHeight)
        
        // Adjust the tap location based on the scale factor and vertical offset
        let adjustedTapY = (tapLocation.y - offsetY) / scaleFactor
        
        print("Adjusted Tap Location: \(adjustedTapY)")

        let text2Rect = CGRect(x: 21, y: 54, width: 108, height: 21)
        
        if text2Rect.contains(CGPoint(x: tapLocation.x / scaleFactor, y: adjustedTapY)) {
            print("Text 'Kamennaja Gorka' tapped!")
            delegate?.didSelectStation(self)
        } else {
            print("Tap missed: \(tapLocation)")
        }
    }
}
