//
//  MapView.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 19.11.24.
//

import UIKit

class MetroMapView: UIView {
    
    override class var layerClass: AnyClass {
        return CATiledLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        if let tiledLayer = self.layer as? CATiledLayer {
            tiledLayer.levelsOfDetail = 3 // Number of zoom-out levels
            tiledLayer.levelsOfDetailBias = 2 // Number of zoom-in levels
            tiledLayer.tileSize = CGSize(width: 500, height: 500) // Tile size
        }
        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Save the current context state
        context.saveGState()

        // Translate the context so the tile aligns with the global view coordinates
//        context.translateBy(x: -rect.origin.x, y: -rect.origin.y)

        // Clip the drawing to the current tile
        context.clip(to: rect)

        // Draw the full content, but only visible parts will be rendered
        StyleKit.drawCanvas1(frame: self.bounds)

        // Restore the context state
        context.restoreGState()
    }
}
