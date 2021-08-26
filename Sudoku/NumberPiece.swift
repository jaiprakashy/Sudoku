//
//  NumberPiece.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 25/06/21.
//

import Foundation

struct NumberPiece: Equatable {
    var value: Int
    var isStatic: Bool
    
    static var emptyPiece: NumberPiece {
        return NumberPiece(value: 0, isStatic: false)
    }
    
    func stringValue() -> String {
        return value == 0 ? " " : "\(value)"
    }
    
    static func ==(lhs: NumberPiece, rhs: NumberPiece) -> Bool {
        return lhs.value == rhs.value
    }
}
