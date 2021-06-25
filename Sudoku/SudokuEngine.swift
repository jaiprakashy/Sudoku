//
//  SudokuEngine.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import Foundation

struct SudokuEngine {
    var board: Array<Array<NumberPiece>> = [[]]
    var dimension: Int
    
    init(dimension: Int) {
        self.dimension = dimension
    }
    
    mutating func initializeEmptyGame() {
        board = Array(repeating: Array(repeating: NumberPiece(value: 0, isStatic: false), count: dimension), count: dimension)
    }
    
    mutating func initializeSampleGame() {
        board = sampleGame()
    }
    
    func sampleGame() -> Array<Array<NumberPiece>> {
        return [
            [7, 8, 0, 4, 0, 0, 1, 2, 0],
            [6, 0, 0, 0, 7, 5, 0, 0, 9],
            [0, 0, 0, 6, 0, 1, 0, 7, 8],
            [0, 0, 7, 0, 4, 0, 2, 6, 0],
            [0, 0, 1, 0, 5, 0, 9, 3, 0],
            [9, 0, 4, 0, 6, 0, 0, 0, 5],
            [0, 7, 0, 3, 0, 0, 0, 1, 2],
            [1, 2, 0, 0, 0, 7, 4, 0, 0],
            [0, 4, 9, 2, 0, 6, 0, 0, 7]
        ].map{ numArray in
            return numArray.map({ NumberPiece(value: $0, isStatic: $0 != 0) })
        }
    }
}

extension SudokuEngine: CustomStringConvertible {
    var description: String {
        let desc = "Sudoku Engine"

        return desc
    }
}
