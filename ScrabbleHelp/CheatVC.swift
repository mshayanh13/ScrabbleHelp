//
//  CheatVC.swift
//  ScrabbleHelp
//
//  Created by Mohammad Shayan on 5/3/20.
//  Copyright © 2020 Mohammad Shayan. All rights reserved.
//

import UIKit

class CheatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var wordsDictionary: [String: Int]!
    var wordsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeWordsArray()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    func makeWordsArray() {
        for word in wordsDictionary.keys {
            wordsArray.append(word)
        }
        wordsArray.sort { (word1, word2) -> Bool in
            let points1 = wordsDictionary[word1]!
            let points2 = wordsDictionary[word2]!
            
            return points1 > points2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let word = wordsArray[indexPath.row]
        let points = wordsDictionary[word]!
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell")
        cell?.textLabel?.text = word
        cell?.detailTextLabel?.text = "\(points)"
        return cell ?? UITableViewCell()
    }
    
}
