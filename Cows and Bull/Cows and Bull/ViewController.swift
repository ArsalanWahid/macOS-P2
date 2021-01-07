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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func submitGuess(_ sender: NSButton) {
        
    }
    
}

