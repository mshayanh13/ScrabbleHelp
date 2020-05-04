//
//  MainVC.swift
//  ScrabbleHelp
//
//  Created by Mohammad Shayan on 5/3/20.
//  Copyright © 2020 Mohammad Shayan. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var letters = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letters = Scrabble.shared.startingLetters
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let letter = letters[indexPath.row]
        let points = Scrabble.shared.letterPoints[letter] ?? 0
        let cell = tableView.dequeueReusableCell(withIdentifier: "LetterCell")
        cell?.textLabel?.text = letter
        cell?.detailTextLabel?.text = "\(points)"
        return cell ?? UITableViewCell()
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Scrabble.shared.restartGame()
        letters = Scrabble.shared.startingLetters
        tableView.reloadData()
    }
    
    @IBAction func cheatButtonTapped(_ sender: UIButton) {
        Scrabble.shared.cheat()
        let wordsDictionary = Scrabble.shared.wordsCombo
        performSegue(withIdentifier: "CheatVC", sender: wordsDictionary)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheatVC" {
            let destination = segue.destination as! CheatVC
            let wordsDictionary = sender as! [String: Int]
            destination.wordsDictionary = wordsDictionary
        }
    }
}
