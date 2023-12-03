//
//  main.swift
//  Day 02
//
//  Created by Bence Tóth on 03/12/2023.
//

import Foundation

struct Game {
    var id: Int
    var cubes: [Cube] = []
    
    var reds: Int {
        var max = 0
        for cube in cubes {
            if cube.red ?? 0 > max {
                max = cube.red ?? 0
            }
        }
        return max
    }
    
    var greens: Int {
        var max = 0
        for cube in cubes {
            if cube.green ?? 0 > max {
                max = cube.green ?? 0
            }
        }
        return max
    }
    
    var blues: Int {
        var max = 0
        for cube in cubes {
            if cube.blue ?? 0 > max {
                max = cube.blue ?? 0
            }
        }
        return max
    }
    
    var underThelimit: Bool {
        return self.reds <= 12 && self.greens <= 13 && self.blues <= 14
    }
    
    var power: Int {
        return reds * greens * blues
    }
    
    init(_ str: String) {
        id = Int(str.components(separatedBy: ": ").first?.dropFirst(5) ?? "0") ?? 0
        let draws = str.components(separatedBy: ": ")[1].components(separatedBy: "; ")
        for draw in draws {
            cubes.append(Cube(draw: draw))
        }
    }
}

struct Cube {
    var red: Int?
    var green: Int?
    var blue: Int?
    
    init(draw: String) {
        var draws = draw.components(separatedBy: ", ")
        for cube in draws {
            let tmp = cube.components(separatedBy: " ")
            if tmp[1] == "red" {
                red = Int(tmp.first ?? "0")
            }
            if tmp[1] == "green" {
                green = Int(tmp.first ?? "0")
            }
            if tmp[1] == "blue" {
                blue = Int(tmp.first ?? "0")
            }
        }
    }
}

class Day02: AOCDay {
    
    var input: [Game] {
        FileOpener.shared.openFile(day: "02", test: false).components(separatedBy: "\n").map {
            Game($0)
        }
    }
    
    func partOne() -> Int {
        input.map{ $0.underThelimit ? $0.id : 0 }.reduce(0, +)
    }
    
    func partTwo() -> Int {
        input.map{ $0.power }.reduce(0, +)
    }
}

print(Day02().partOne())
print(Day02().partTwo())
