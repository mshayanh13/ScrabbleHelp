//
//  Game.swift
//  ScrabbleHelp
//
//  Created by Mohammad Shayan on 5/3/20.
//  Copyright © 2020 Mohammad Shayan. All rights reserved.
//

import UIKit

struct Scrabble {
    
    static var shared = Scrabble()
    
    private (set) public var trie = Trie()
    
    private (set) public var letterPoints = [String: Int]()
    private (set) public var lettersInBagStartings = [String: Int]()
    
    private (set) public var lettersInBag = [String: Int]()
    private (set) public var arrayBag = [String]()
    
    private(set) public var startingLetters = [String]()
    private(set) public var wordsCombo = [String: Int]()
    
    init() {
        setupPoints()
        setupQuantities()
        lettersInBag = lettersInBagStartings
        makeArray()
        startGame()
        
        setupTrie()
    }
    
    func setupTrie() {
        
        var tempArray = [String]()
        
        let resourcePath = Bundle.main.resourcePath! as NSString
        let fileName = "dictionary.txt"
        let filePath = resourcePath.appendingPathComponent(fileName)
        
        var data: String?
        do {
            data = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch let error {
            print(error.localizedDescription)
        }
        tempArray = data!.components(separatedBy: .whitespacesAndNewlines)
        for word in tempArray {
            trie.insert(word: word)
        }
    }

    private mutating func setupPoints() {
        letterPoints["A"] = 1
        letterPoints["E"] = 1
        letterPoints["I"] = 1
        letterPoints["O"] = 1
        letterPoints["N"] = 1
        letterPoints["R"] = 1
        letterPoints["T"] = 1
        letterPoints["L"] = 1
        letterPoints["S"] = 1
        letterPoints["U"] = 1
        
        letterPoints["D"] = 2
        letterPoints["G"] = 2
        
        letterPoints["B"] = 3
        letterPoints["C"] = 3
        letterPoints["M"] = 3
        letterPoints["P"] = 3
        
        letterPoints["F"] = 4
        letterPoints["H"] = 4
        letterPoints["V"] = 4
        letterPoints["W"] = 4
        letterPoints["Y"] = 4
        
        letterPoints["K"] = 5
        
        letterPoints["J"] = 8
        letterPoints["X"] = 8
        
        letterPoints["Q"] = 10
        letterPoints["Z"] = 10
    }

    private mutating func setupQuantities() {
        lettersInBagStartings["A"] = 2
        lettersInBagStartings["B"] = 2
        lettersInBagStartings["C"] = 2
        lettersInBagStartings["D"] = 4
        lettersInBagStartings["E"] = 12
        lettersInBagStartings["F"] = 2
        lettersInBagStartings["G"] = 3
        lettersInBagStartings["H"] = 2
        lettersInBagStartings["I"] = 9
        lettersInBagStartings["J"] = 1
        lettersInBagStartings["K"] = 1
        lettersInBagStartings["L"] = 4
        lettersInBagStartings["M"] = 2
        lettersInBagStartings["N"] = 6
        lettersInBagStartings["O"] = 8
        lettersInBagStartings["P"] = 2
        lettersInBagStartings["Q"] = 1
        lettersInBagStartings["R"] = 6
        lettersInBagStartings["S"] = 4
        lettersInBagStartings["T"] = 6
        lettersInBagStartings["U"] = 4
        lettersInBagStartings["V"] = 2
        lettersInBagStartings["W"] = 2
        lettersInBagStartings["X"] = 1
        lettersInBagStartings["Y"] = 2
        lettersInBagStartings["Z"] = 1
    }

    mutating func makeArray() {
        for (key, value) in lettersInBag {
            for _ in 1...value {
                arrayBag.append(key)
            }
        }
    }
    
    mutating func startGame() {
        
        for _ in 1...7 {
            let randomInt = Int.random(in: 0..<arrayBag.count)
            let randomLetter = arrayBag.remove(at: randomInt)
            startingLetters.append(randomLetter)
        }
    }
    
    mutating func restartGame() {
        startingLetters.removeAll()
        wordsCombo.removeAll()
        lettersInBag = lettersInBagStartings
        makeArray()
        startGame()
    }
    
    func getWordPointFor(_ word: String) -> Int {
        var points = 0
        for letter in word {
            let letter = String(letter).uppercased()
            points += letterPoints[letter]!
        }
        return points
    }
    
    mutating func cheat() {
        let results = makeCombos()
        for result in results {
            let points = getWordPointFor(result)
            wordsCombo[result] = points
        }
    }
    
    private func makeCombos() -> [String] {
        
        var letters = Array<Character>()
        
        for letter in startingLetters {
            letters.append(letter.lowercased().first!)
        }
        
        var results = Set<String>()
        
        trie.findWordsFromLettersArray(&letters, start: 0, end: letters.count-1, results: &results)
        
        return Array<String>(results)
    }
}
