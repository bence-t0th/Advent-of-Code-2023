//
//  main.swift
//  Day 04
//
//  Created by Bence Tóth on 09/12/2023.
//

import Foundation

struct Game {
    var id: Int
    var matchingNumbers: Int
    
    var points: Int {
        matchingNumbers > 0 ? NSDecimalNumber(decimal: pow(2, matchingNumbers - 1)).intValue : 0
    }
    
    init(_ game: String) {
        id = Int((game.components(separatedBy: ":").first?.split(separator: " ").last)!)!
        
        var winningNumbers = game.components(separatedBy: ":").last?.components(separatedBy: "|").first?.split(separator: " ").map {
            $0.first == " " ? Int(String($0.dropFirst()))! : Int($0)!
        }
        
        var myNumbers = game.components(separatedBy: ":").last?.components(separatedBy: "|").last?.split(separator: " ").map {
            $0.first == " " ? Int(String($0.dropFirst()))! : Int($0)!
        }
        
        if let winningNumbers, let myNumbers {
            matchingNumbers = Set(winningNumbers).intersection(Set(myNumbers)).count
            return
        }
        matchingNumbers = 0
    }
}

class Day04: AOCDay {
    
    var input: [Game] {
        FileOpener.shared.openFile(day: "04", test: false).components(separatedBy: "\n").map { Game($0) }
    }
    
    func partOne() -> Int {
        return input.map(\.points).reduce(0, +)
    }
    
    func partTwo() -> Int {
        var copies = [Int](repeating: 1, count: input.count + 1)
        copies[0] = 0
        
        for game in input {
            if game.matchingNumbers > 0 {
                for i in game.id + 1 ... game.id + game.matchingNumbers {
                    copies[i] += copies[game.id]
                }
            }
        }
        return copies.reduce(0, +)
    }
}

print(Day04().partOne())
print(Day04().partTwo())
