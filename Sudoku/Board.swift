//
//  Board.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 25/06/21.
//

import Foundation

struct Board {
    private var boardArray = Array<Array<NumberPiece>>()
    
    var isBoardFull: Bool {
        for row in boardArray where row.contains(NumberPiece.emptyPiece) {
            return false
        }
        return true
    }
    
    init(dimension: Int) {
        boardArray = Array(repeating: Array(repeating: NumberPiece.emptyPiece, count: dimension), count: dimension)
    }
    
    mutating func removePiece(at position: Position) {
        boardArray[position.row][position.col] = NumberPiece.emptyPiece
    }
    
    subscript(position: Position) -> NumberPiece {
        get {
            return boardArray[position.row][position.col]
        }
        
        set {
            boardArray[position.row][position.col] = newValue
        }
    }
    
    mutating func reset() {
        boardArray = boardArray.map({ row in
            return row.map({ return $0.isStatic ? $0 : NumberPiece.emptyPiece })
        })
    }
}
