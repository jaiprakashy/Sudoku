//
//  BoardDelegate.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import Foundation

protocol BoardDelegate: class {
    func selectedPosition(position: Position?)
    func canHighlight(at postion: Position) -> Bool
}
