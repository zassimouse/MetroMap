//
//  MetroTransfer.swift
//  MetroMap
//
//  Created by Denis Haritonenko on 3.12.24.
//

import Foundation

class MetroNetwork {
    
    static var shared = MetroNetwork()
    
    private var stations: [Int: MetroStation] = [:]
    
    init() {
        createStations()
        createConnections()
    }
    
    func getStation(_ number: Int) -> MetroStation? {
//        print(stations[number] ?? "not found")
        return stations[number]
    }
    
    // Create all stations
    private func createStations() {
        // Line 1
        stations[124] = MetroStation(number: 124, name: "Uruchcha", line: 1, travelTimeToNext: 3)
        stations[123] = MetroStation(number: 123, name: "Barysawski Trakt", line: 1, travelTimeToNext: 2)
        stations[122] = MetroStation(number: 122, name: "Uschod", line: 1, travelTimeToNext: 3)
        stations[121] = MetroStation(number: 121, name: "Maskowskaja", line: 1, travelTimeToNext: 2)
        stations[120] = MetroStation(number: 120, name: "Park Chaluskincaw", line: 1, travelTimeToNext: 2)
        stations[119] = MetroStation(number: 119, name: "Akademija navuk", line: 1, travelTimeToNext: 1)
        stations[118] = MetroStation(number: 118, name: "Ploshcha Yakuba Kolasa", line: 1, travelTimeToNext: 2)
        stations[117] = MetroStation(number: 117, name: "Ploshcha Peramohi", line: 1, travelTimeToNext: 2)
        stations[116] = MetroStation(number: 116, name: "Kastrychnickaja", line: 1, travelTimeToNext: 2)
        stations[115] = MetroStation(number: 115, name: "Ploshcha Lenina", line: 1, travelTimeToNext: 2)
        stations[114] = MetroStation(number: 114, name: "Institut Kultury", line: 1, travelTimeToNext: 3)
        stations[113] = MetroStation(number: 113, name: "Grushawka", line: 1, travelTimeToNext: 2)
        stations[112] = MetroStation(number: 112, name: "Mihalova", line: 1, travelTimeToNext: 2)
        stations[111] = MetroStation(number: 111, name: "Piatrowshchyna", line: 1, travelTimeToNext: 2)
        stations[110] = MetroStation(number: 110, name: "Malinawka", line: 1, travelTimeToNext: 0)
        
        // Line 2
        stations[223] = MetroStation(number: 223, name: "Kamennaja Gorka", line: 2, travelTimeToNext: 2)
        stations[222] = MetroStation(number: 222, name: "Kuncawshchyna", line: 2, travelTimeToNext: 2)
        stations[221] = MetroStation(number: 221, name: "Spartywnaja", line: 2, travelTimeToNext: 2)
        stations[220] = MetroStation(number: 220, name: "Pushkinskaja", line: 2, travelTimeToNext: 3)
        stations[219] = MetroStation(number: 219, name: "Maladziozhnaja", line: 2, travelTimeToNext: 2)
        stations[218] = MetroStation(number: 218, name: "Frunzenskaja", line: 2, travelTimeToNext: 2)
        stations[217] = MetroStation(number: 217, name: "Niamiha", line: 2, travelTimeToNext: 1)
        stations[216] = MetroStation(number: 216, name: "Kupalawskaja", line: 2, travelTimeToNext: 2)
        stations[215] = MetroStation(number: 215, name: "Pershamajskaja", line: 2, travelTimeToNext: 2)
        stations[214] = MetroStation(number: 214, name: "Praletarskaja", line: 2, travelTimeToNext: 3)
        stations[213] = MetroStation(number: 213, name: "Traktarny Zavod", line: 2, travelTimeToNext: 3)
        stations[212] = MetroStation(number: 212, name: "Partyzanskaja", line: 2, travelTimeToNext: 3)
        stations[211] = MetroStation(number: 211, name: "Awtazavodskaja", line: 2, travelTimeToNext: 3)
        stations[210] = MetroStation(number: 210, name: "Magiliowskaja", line: 2, travelTimeToNext: 0)
        
        // Line 3
        stations[316] = MetroStation(number: 316, name: "Jubilejnaja Ploshcha", line: 3, travelTimeToNext: 2)
        stations[315] = MetroStation(number: 315, name: "Ploshcha Francishka Bahushevicha", line: 3, travelTimeToNext: 2)
        stations[314] = MetroStation(number: 314, name: "Vakzalnaja", line: 3, travelTimeToNext: 3)
        stations[313] = MetroStation(number: 313, name: "Kavalskaja Slabada", line: 3, travelTimeToNext: 0)
    }
    
    // Create all connections
    private func createConnections() {
        // Line 1 connections
        connectStations(from: 124, to: 123)
        connectStations(from: 123, to: 122)
        // Continue for all Line 1 stations...
        
        // Line 2 connections
        connectStations(from: 223, to: 222)
        connectStations(from: 222, to: 221)
        // Continue for all Line 2 stations...
        
        // Line 3 connections
        connectStations(from: 316, to: 315)
        connectStations(from: 315, to: 314)
        // Continue for all Line 3 stations...
        
        // Transitions
        connectStations(from: 218, to: 316, transitionTime: 3) // Frunzenskaja <-> Jubilejnaja Ploshcha
        connectStations(from: 116, to: 216, transitionTime: 3) // Kastrychnickaja <-> Kupalawskaja
        connectStations(from: 115, to: 314, transitionTime: 5) // Ploshcha Lenina <-> Vakzalnaja
    }
    
    // Helper to connect stations
    private func connectStations(from: Int, to: Int, transitionTime: Int = 0) {
        guard let station1 = stations[from], let station2 = stations[to] else { return }
        station1.connections.append((station: station2, transitionTime: transitionTime))
        station2.connections.append((station: station1, transitionTime: transitionTime))
    }
    
    // Find route using BFS
    func findRoute(from startNumber: Int, to endNumber: Int) -> ([MetroStation], Int) {
        guard let startStation = stations[startNumber], let endStation = stations[endNumber] else { return ([], 0) }
        
        var queue: [(path: [MetroStation], time: Int)] = [([startStation], 0)]
        var visited: Set<Int> = [startStation.number]
        
        while !queue.isEmpty {
            let (path, currentTime) = queue.removeFirst()
            let currentStation = path.last!
            
            // If we reached the destination
            if currentStation.number == endStation.number {
                return (path, currentTime)
            }
            
            // Enqueue unvisited connections
            for connection in currentStation.connections {
                if !visited.contains(connection.station.number) {
                    let timeToNext = currentStation.line == connection.station.line
                        ? currentStation.travelTimeToNext
                        : connection.transitionTime
                    queue.append((path + [connection.station], currentTime + timeToNext))
                    visited.insert(connection.station.number)
                }
            }
        }
        
        // No route found
        return ([], 0)
    }
    
    func findStationsByName(_ name: String) -> [MetroStation] {
        // Find all stations containing the search string (case insensitive)
        return stations.values.filter { $0.name.lowercased().contains(name.lowercased()) }
    }
}
