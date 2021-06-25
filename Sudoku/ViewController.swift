//
//  ViewController.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    
    var sudokuEngine: SudokuEngine = SudokuEngine(dimension: 9)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sudokuEngine.initializeSampleGame()
        boardView.delegate = self
        boardView.shadowBoard = sudokuEngine.board
        boardView.setNeedsDisplay()
    }
    
    @IBAction func inputButtonTapped(sender: UIButton) {
        if sender.title(for: .normal) == "X" {
            // clear
        } else {
            // number
        }
    }
}

extension ViewController: BoardDelegate {
    func enter(value: Int, atPosition position: Position) {
        
    }
    
    func value(atPosition position: Position) -> Int {
        return 0
    }
}

