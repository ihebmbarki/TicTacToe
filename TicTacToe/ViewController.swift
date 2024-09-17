//
//  ViewController.swift
//  TicTacToe
//
//  Created by Iheb Mbarki on 6/9/2024.
//

import UIKit

class ViewController: UIViewController {

    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn   = Turn.Cross
    var currentTurn = Turn.Cross
    
    var Nought      = "O"
    var Cross       = "X"
    var board       = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    
    var gameActive = true
 
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
        
        // Apply custom style to each button
        for button in board {
            button.setCustomStyle()
        }
    }
    
    
    func resultAllert(title: String){
        
        let message = "\nNoughts: " + String(noughtsScore) + "\nCrosses: " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {  _ in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    
    func resetBoard() {
        for button in board {
            button.setTitle("", for: .normal) // Reset to blank
            button.isEnabled = true
        }
        
        currentTurn = firstTurn
        turnLabel.text = (currentTurn == Turn.Nought) ? Nought : Cross
        gameActive = true // Reset game active state
    }
    

    @IBAction func boardTapAction(_ sender: UIButton) {
        if !gameActive {
               return // Ignore taps if the game is not active
           }
           
           addToBoard(sender)
           
           if checkForVictory(Cross) {
               crossesScore += 1
               resultAllert(title: "Crosses win!")
               gameActive = false // End the game
               return
           }
           
           if checkForVictory(Nought) {
               noughtsScore += 1
               resultAllert(title: "Noughts win!")
               gameActive = false // End the game
               return
           }
           
           if fullBoard() {
               resultAllert(title: "Draw")
               gameActive = false // End the game
           }
    }
    
    
    func checkForVictory(_ s: String) -> Bool {
        // Horizontal victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) { return true }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) { return true }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) { return true }

        // Vertical victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) { return true }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) { return true }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) { return true }

        // Diagonal victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) { return true }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) { return true }

        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == "" {
                return false
            }
        }
        return true
    }

    
    
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil || sender.title(for: .normal) == "" {
            if currentTurn == Turn.Nought {
                sender.setTitle(Nought, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = Cross
            } else {
                sender.setTitle(Cross, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = Nought
            }
            sender.isEnabled = false
        }
    }
}

extension UIButton {
    func setCustomStyle() {
        // Set the title label font size, weight, and color
        self.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        self.setTitleColor(.black, for: .normal)
    }
}
