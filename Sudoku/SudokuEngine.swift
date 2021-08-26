//
//  SudokuEngine.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import Foundation

struct SudokuEngine {
    var board: Board!
    var dimension: Int
    
    init(dimension: Int) {
        self.dimension = dimension
    }
    
    mutating func initializeEmptyGame() {
        self.board = Board(dimension: dimension)
    }
    
    mutating func initializeSampleGame() {
        self.board = sampleBoard(dimension: dimension)
    }
    
    func sampleBoard(dimension: Int) -> Board {
        let game = [
            [7, 8, 0, 4, 0, 0, 1, 2, 0],
            [6, 0, 0, 0, 7, 5, 0, 0, 9],
            [0, 0, 0, 6, 0, 1, 0, 7, 8],
            [0, 0, 7, 0, 4, 0, 2, 6, 0],
            [0, 0, 1, 0, 5, 0, 9, 3, 0],
            [9, 0, 4, 0, 6, 0, 0, 0, 5],
            [0, 7, 0, 3, 0, 0, 0, 1, 2],
            [1, 2, 0, 0, 0, 7, 4, 0, 0],
            [0, 4, 9, 2, 0, 6, 0, 0, 7]
        ]
        
        var board = Board(dimension: dimension)
        for row in 0 ..< dimension {
            for col in 0 ..< dimension {
                let value = game[row][col]
                let position = Position(row: row, col: col)
                board[position] = value == 0 ? NumberPiece.emptyPiece : NumberPiece(value: value, isStatic: true)
            }
        }
        return board
    }
    
    func canEdit(at position: Position) -> Bool {
        let piece = board[position]
        return !piece.isStatic
    }
    
    func canInsert(piece: NumberPiece, atPosition position: Position) -> Bool {
        return true
    }
    
    mutating func insert(piece: NumberPiece, atPosition position: Position) {
        board[position] = piece
    }
    
    mutating func deletePiece(at position: Position) {
        board.removePiece(at: position)
    }
    
    func newGame() -> Board {
        return Board(dimension: 10)
    }
    
    mutating func resetGame() {
        board.reset()
    }
    
    func solution(for board: Board) {
        
    }
}

extension SudokuEngine: CustomStringConvertible {
    var description: String {
        var desc = "-----------------------\n"
        for row in 0 ..< dimension {
            for col in 0 ..< dimension {
                desc += board[Position(row: row, col: col)].stringValue()
            }
            desc += "\n"
        }
        desc += "-----------------------"
        return desc
    }
}
