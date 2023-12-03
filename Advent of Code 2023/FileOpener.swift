//
//  FileOpener.swift
//  Day 01
//
//  Created by Bence Tóth on 03/12/2023.
//

import Foundation

class FileOpener {
    static let shared = FileOpener()
    
    func openFile(day: String, test: Bool = false) -> String {
        let path = "/Users/bencetoth/Documents/Advent-of-Code-2023/Advent of Code 2023/Day \(day)/\(day)\(test ? "_test" : "").txt"
        do {
            return try String(contentsOfFile: path, encoding: .utf8)
        }
        catch let error {
            return ("Ooops! Something went wrong: \(error)")
        }
    }
}
