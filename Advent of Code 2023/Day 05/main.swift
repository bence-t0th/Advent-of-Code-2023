//
//  main.swift
//  Day 05
//
//  Created by Bence Tóth on 11/12/2023.
//

import Foundation

struct Almanac {
    var seeds: [Int]
    var maps: [Map]
    
    var moreSeeds: [Int] {
        let chunks = seeds.chunked(into: 2)
        var seeds: [Int] = []
        _ = chunks.map {
            for i in $0.first! ... $0.first! + $0.last! {
                seeds.append(i)
            }
        }
        return seeds
    }
    
    var minimumLocation: Int {
        seeds.map { getLocation(for: $0) }.min() ?? 0
    }
    
    var miniumLocationForMoreSeed: Int {
        moreSeeds.map { getLocation(for: $0) }.min() ?? 0
    }
    
    func getLocation(for seed: Int) -> Int {
        var seed = seed
        for map in maps {
            if let range = map.ranges.first(where: { ($0.start...$0.end).contains(seed) }) {
                seed += range.difference
            }
        }
        return seed
    }
}

struct Map {
    var ranges: [Range]
    
    init(_ ranges: [String]) {
        self.ranges = ranges.map { Range($0) }.sorted { $0.start < $1.start }
    }
}

struct Range {
    var start: Int
    var end: Int
    var difference: Int
    
    init(_ range: String) {
        let parts = range.components(separatedBy: " ")
        start = Int(parts[1])!
        end = start + Int(parts.last!)! - 1
        difference = Int(parts.first!)! - start
    }
}

class Day05: AOCDay {
    
    var input = FileOpener.shared.openFile(day: "05", test: false).components(separatedBy: "\n\n")
    
    var almanac: Almanac {
        return Almanac(seeds: getSeeds(line: input.first!), maps: getMaps())
    }
    
    private func getSeeds(line: String) -> [Int] {
        input.first?
            .components(separatedBy: ": ").last?
            .components(separatedBy: " ")
            .map { Int($0)! } ?? []
    }
    
    private func getMaps() -> [Map] {
        input
            .map { $0.components(separatedBy: "\n") }
            .map { [String]($0.dropFirst()) }
            .map { Map($0) }
            .suffix(input.count - 1)
    }
    
    func partOne() -> Int {
        almanac.minimumLocation
    }
    
    func partTwo() -> Int {
        almanac.miniumLocationForMoreSeed
    }
}

print(Day05().partOne())
print(Day05().partTwo())

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
