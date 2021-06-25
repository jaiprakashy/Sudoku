//
//  BoardDelegate.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import Foundation

protocol BoardDelegate: class {
    func enter(value: Int, atPosition position: Position)
    func value(atPosition position: Position) -> Int
}
