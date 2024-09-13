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
        
        for button in board {
                button.setCustomStyle()
            }
    }
    
    
    func resultAllert(title: String){
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    
    func resetBoard() {
        for button in board{
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if (firstTurn == Turn.Nought) {
            firstTurn = Turn.Cross
            turnLabel.text = Cross
        }
        else if (firstTurn == Turn.Cross) {
            firstTurn = Turn.Nought
            turnLabel.text = Nought
        }
        currentTurn = firstTurn
        
    }
    

    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if (fullBoard()){
            resultAllert(title: "Draw")
        }
    }
    
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    
    func addToBoard(_ sender: UIButton) {
        if (sender.title(for: .normal) == nil) {
            if (currentTurn == Turn.Nought) {
                sender.setTitle(Nought, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = Cross
            } else if (currentTurn == Turn.Cross) {
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
        self.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        self.setTitleColor(.black, for: .normal)
    }
}
