//
//  ViewController.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var stateFlag: UIImageView!
    var dimension: Int = 9
    var selectedPosition: Position?
    
    var sudokuEngine: SudokuEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sudokuEngine = SudokuEngine(dimension: dimension)
        sudokuEngine.initializeSampleGame()
        
        boardView.delegate = self
        updateBoard()
    }
    
    @IBAction func inputButtonTapped(sender: UIButton) {
        guard let stringValue = sender.title(for: .normal) else { return }
        if stringValue == "X" {
            deletePiece()
        } else {
            if let intValue = Int(stringValue) {
                insert(piece: NumberPiece(value: intValue, isStatic: false))
            }
        }
    }
    
    @IBAction func newGameButtonTapped(sender: UIButton) {
        
    }
    
    @IBAction func resetButtonTapped(sender: UIButton) {
        
    }
    
    func insert(piece: NumberPiece) {
        guard let position = selectedPosition,
              sudokuEngine.canInsert(piece: piece, atPosition: position) else {
            return
        }
        sudokuEngine.insert(piece: piece, atPosition: position)
        updateBoard()
    }
    
    func deletePiece() {
        guard let position = selectedPosition else { return }
        
        sudokuEngine.deletePiece(at: position)
        updateBoard()
    }
    
    func updateBoard() {
        boardView.dimension = dimension
        boardView.shadowBoard = sudokuEngine.board
        boardView.setNeedsDisplay()
    }
}

extension ViewController: BoardDelegate {
    func selectedPosition(position: Position?) {
        self.selectedPosition = position
    }
    
    func canHighlight(at postion: Position) -> Bool {
        sudokuEngine.canEdit(at: postion)
    }
}

