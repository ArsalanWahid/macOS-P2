//
//  ViewController.swift
//  Cows and Bull
//
//  Created by Arsalan Wahid Asghar on 06/01/2021.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate,NSTableViewDataSource {
    
    @IBOutlet var guess: NSTextField!
    @IBOutlet var tableView: NSTableView!
    
    var answer = ""
    var guesses  = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func submitGuess(_ sender: NSButton) {
    }
    
    //MARK:- Table View methods
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        if tableColumn?.title == "Guess"{
            vw.textField?.stringValue = guesses[row]
        }else {
            vw.textField?.stringValue = result(for: guesses[row])
        }
        
        return vw
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    // MARK:- Custom Methods
    func result (for guess: String) -> String {
        var bulls = 0
        var cows = 0
        var guessLetters = Array(guess)
        var answerLetters = Array(answer)
        for (index , letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            }else if answerLetters.contains(letter) {
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
    }
    
    
    func startNewGame() {
        guess.stringValue = ""
        guesses.removeAll()
        var numbers = Array(0...9)
        numbers.shuffle()
        print(numbers)
        for x in 0..<4 {
            answer.append(String(numbers.removeLast()))
        }
        tableView.reloadData()
    }
    
}

