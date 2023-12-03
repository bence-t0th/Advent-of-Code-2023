//
//  main.swift
//  Day 01
//
//  Created by Bence Tóth on 03/12/2023.
//

import Foundation

class Day01 {
    
    var input: [String] {
        return FileOpener.shared.openFile(day: "01").components(separatedBy: "\n")
    }
    
    var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9",
                "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "0"]
    
    func solveFirst() -> Int {
        var res = 0
        for line in input {
            var valueInLine = 0
            let onlyNumbers = line.filter("0123456789".contains)
            valueInLine += (onlyNumbers.first?.wholeNumberValue ?? 0) * 10
            valueInLine += (onlyNumbers.last?.wholeNumberValue ?? 0)
            res += valueInLine
        }
        return res
    }
    
    func solveSecond() -> Int {
        var res = 0
        for line in input {
            res += (findFirstNumber(in: line) + findLastNumber(in: line))
        }
        return res
    }
    
    private func findFirstNumber(in line: String) -> Int {
        var line = line
        var tmpString = ""
        
        for char in line {
            tmpString.append(char)
            if !numbers.filter(tmpString.contains).isEmpty {
                return 10 * ((numbers.firstIndex(of: numbers.filter(tmpString.contains).first ?? "0") ?? 0) % 9 + 1)
            } else {
                line = String(line.dropFirst())
            }
        }
        return -1
    }
    
    private func findLastNumber(in line: String) -> Int {
        var line = line
        var tmpString = ""
        
        for char in line.reversed() {
            tmpString.insert(char, at: tmpString.startIndex)
            if !numbers.filter(tmpString.contains).isEmpty {
                return ((numbers.firstIndex(of: numbers.filter(tmpString.contains).first ?? "0") ?? 0) % 9 + 1)
            } else {
                line = String(line.dropFirst())
            }
        }
        return -1
    }
}

print(Day01().solveFirst())
print(Day01().solveSecond())
