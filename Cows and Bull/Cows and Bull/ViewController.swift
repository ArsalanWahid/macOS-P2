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
        
//        validate user input
        let guessString = guess.stringValue
        guard Set(guessString).count == 4 else { return }
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else {
            return
        }
        
//        insert data for tableiveiew
        guesses.insert(guessString, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
//        show alert if user wins
        let resultString = result(for: guessString)
        if resultString.contains("4b") {
            let alert = NSAlert()
            alert.messageText = "You win"
            alert.informativeText = "Congraulations click ok to play again"
            alert.runModal()
            startNewGame()
        }
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
        print(answer)
        tableView.reloadData()
    }
    
}

