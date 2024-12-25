//
//  MetroStation.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 3.12.24.
//

import Foundation

class MetroStation {
    let number: Int
    let name: String
    let line: Int
    let travelTimeToNext: Int
    var connections: [(station: MetroStation, transitionTime: Int)] = []
    
    init(number: Int, name: String, line: Int, travelTimeToNext: Int) {
        self.number = number
        self.name = name
        self.line = line
        self.travelTimeToNext = travelTimeToNext
    }
}
