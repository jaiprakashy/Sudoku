//
//  ViewController.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import UIKit

enum SudokuLevel: Int {
    case easy
    case medium
    case difficult
    
    var missingNumbers: Int {
        switch self {
        case .easy: return 48
        case .medium: return 54
        case .difficult: return 60
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var stateFlag: UIImageView!
    @IBOutlet weak var levelSegmentedControl: UISegmentedControl!
    var dimension: Int = 9
    var selectedPosition: Position?
    
    var sudokuEngine: SudokuEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        sudokuEngine = SudokuEngine(dimension: dimension)
        boardView.delegate = self
        createNewGame()
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
        createNewGame()
    }
    
    @IBAction func resetButtonTapped(sender: UIButton) {
        stateFlag.tintColor = .red
        boardView.isFrozen = false
        sudokuEngine.resetGame()
        updateBoard()
    }
    
    func insert(piece: NumberPiece) {
        guard let position = selectedPosition,
              sudokuEngine.canInsert(piece: piece, atPosition: position) else {
            return
        }
        sudokuEngine.insert(piece: piece, atPosition: position)
        updateBoard()
        
        if sudokuEngine.isSolved() {
            boardView.isFrozen = true
            stateFlag.tintColor = .green
        }
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
    
    func createNewGame() {
        stateFlag.tintColor = .red
        
        let difficultyLevel = SudokuLevel(rawValue: levelSegmentedControl.selectedSegmentIndex)?.missingNumbers
        sudokuEngine.initializeNewGame(with: difficultyLevel!)
        
        boardView.isFrozen = false
        updateBoard()
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

