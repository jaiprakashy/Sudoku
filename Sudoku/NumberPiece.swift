//
//  NumberPiece.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 25/06/21.
//

import Foundation

struct NumberPiece {
    var value: Int
    var isStatic: Bool
    
    func stringValue() -> String {
        return value == 0 ? " " : "\(value)"
    }
}
