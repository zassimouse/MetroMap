//
//  MapView.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 19.11.24.
//

import UIKit

//protocol MetroMapViewDelegate: AnyObject {
//    func didSelectStation(_ sender: MetroMapView)
//}

protocol MetroMapViewDelegate: AnyObject {
    func didSelectStation(_ station: Int)
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
        
        let stationRects = [
            223 : CGRect(x: 21, y: 54, width: 108, height: 21),
            222 : CGRect(x: 61, y: 93, width: 108, height: 21),
            221 : CGRect(x: 100, y: 134, width: 108, height: 21),
            220 : CGRect(x: 141, y: 174, width: 108, height: 21),
            219 : CGRect(x: 181, y: 219, width: 108, height: 21),
            218 : CGRect(x: 221, y: 254, width: 108, height: 21),
            217 : CGRect(x: 261, y: 294, width: 108, height: 21),
            215 : CGRect(x: 341, y: 374, width: 108, height: 21),
            214 : CGRect(x: 379, y: 415, width: 106, height: 21),
            213 : CGRect(x: 419, y: 455, width: 108, height: 21),
            212 : CGRect(x: 462, y: 498, width: 108, height: 21),
            211 : CGRect(x: 369, y: 541, width: 108, height: 21),
            210 : CGRect(x: 409, y: 584, width: 108, height: 21),
            316 : CGRect(x: 58, y: 277, width: 138, height: 21),
            315 : CGRect(x: 34, y: 317, width: 162, height: 25),
            314 : CGRect(x: 252, y: 392, width: 77, height: 21),
            313 : CGRect(x: 277, y: 470, width: 75, height: 25),
            110 : CGRect(x: 47, y: 598, width: 108, height: 21),
            111 : CGRect(x: 83, y: 562, width: 108, height: 21),
            112 : CGRect(x: 123, y: 522, width: 108, height: 21),
            113 : CGRect(x: 162, y: 482, width: 85, height: 21),
            114 : CGRect(x: 48, y: 428, width: 138, height: 21),
            116 : CGRect(x: 317, y: 326, width: 108, height: 21),
            117 : CGRect(x: 353, y: 290, width: 120, height: 21),
            118 : CGRect(x: 392, y: 251, width: 149, height: 21),
            119 : CGRect(x: 432, y: 210, width: 120, height: 21),
            120 : CGRect(x: 333, y: 163, width: 120, height: 21),
            121 : CGRect(x: 373, y: 123, width: 120, height: 21),
            122 : CGRect(x: 413, y: 83, width: 120, height: 21),
            123 : CGRect(x: 453, y: 43, width: 120, height: 21),
            124 : CGRect(x: 495, y: 0, width: 120, height: 21)]
                         
        for (i, rect) in stationRects {
            if rect.contains(CGPoint(x: tapLocation.x / scaleFactor, y: adjustedTapY)) {
//                print("STATION tapped!")
                delegate?.didSelectStation(i)
                break
            }
        }
        
//        if text2Rect.contains(CGPoint(x: tapLocation.x / scaleFactor, y: adjustedTapY)) {
//            print("Text 'Kamennaja Gorka' tapped!")
//            delegate?.didSelectStation(220)
//        } else {
//            print("Tap missed: \(tapLocation)")
//        }
    }
}
