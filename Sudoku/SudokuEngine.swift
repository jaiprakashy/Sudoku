//
//  SudokuEngine.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import Foundation

typealias Sudoku = (solution: [[Int]], problem: [[Int]])

struct SudokuEngine {
    var board: Board!
    var dimension: Int
    var problem: [[Int]]!
    var solution: [[Int]]!
    
    init(dimension: Int) {
        self.dimension = dimension
    }
    
    mutating func initializeNewGame(with missingNumbers: Int) {
        let sudoku = sudokuGenerator(missingNumbers: missingNumbers)
        solution = sudoku.solution
        problem = sudoku.problem
        
        setupBoard()
    }
    
    mutating func setupBoard() {
        var newBoard = Board(dimension: dimension)
        for row in 0 ..< dimension {
            for col in 0 ..< dimension {
                let value = problem[row][col]
                let position = Position(row: row, col: col)
                newBoard[position] = value == 0 ? NumberPiece.emptyPiece : NumberPiece(value: value, isStatic: true)
            }
        }
        self.board = newBoard
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
    
    func isSolved() -> Bool {
        for row in 0 ..< dimension {
            for col in 0 ..< dimension {
                if board[Position(row: row, col: col)].value != solution[row][col] {
                    return false
                }
            }
        }
        return true
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

fileprivate func sudokuGenerator(missingNumbers: Int) -> Sudoku {
    let dimension = 9
    let boxDimension = 3

    var solution = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)
    var problem = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)


    var random: Int {
        return Int.random(in: 1 ... dimension)
    }

    func isDuplicateInBox(number: Int, row: Int, col: Int) -> Bool {
        let rowStart = Int(row / boxDimension) * boxDimension
        let colStart = Int(col / boxDimension) * boxDimension
        
        for r in rowStart ..< rowStart + boxDimension {
            for c in colStart ..< colStart + boxDimension {
                if solution[r][c] == number {
                    return true
                }
            }
        }
        return false
    }

    func isDuplicateInRow(number: Int, row: Int) -> Bool {
        for col in 0 ..< dimension {
            if solution[row][col] == number {
                return true
            }
        }
        return false
    }

    func isDuplicateInCol(number: Int, col: Int) -> Bool {
        for row in 0 ..< dimension {
            if solution[row][col] == number {
                return true
            }
        }
        return false
    }

    func isSafe(number: Int, row: Int, col: Int) -> Bool {
        return !isDuplicateInBox(number: number, row: row, col: col) &&
            !isDuplicateInRow(number: number, row: row) &&
            !isDuplicateInCol(number: number, col: col)
    }

    func fillBox(row: Int, col: Int) {
        for x in 0 ..< boxDimension {
            for y in 0 ..< boxDimension {
                var randomNumber = random
                
                while isDuplicateInBox(number: randomNumber, row: row, col: col) {
                    randomNumber = random
                }
                solution[row + x][col + y] = randomNumber
            }
        }
    }

    func fillDiagonal() {
        for z in stride(from: 0, to: dimension, by: boxDimension) {
            fillBox(row: z, col: z)
        }
    }

    func fillRemaining(i: Int, j: Int) -> Bool {
        var x = i
        var y = j
        if y >= dimension && x < dimension - 1 {
            x += 1
            y = 0
        }
        
        if x >= dimension && y >= dimension {
            return true
        }
        
        if x < boxDimension {
            if y < boxDimension {
                y  = boxDimension
            }
        } else if x < dimension - boxDimension {
            if y == Int(x / boxDimension) * boxDimension {
                y += boxDimension
            }
        } else {
            if y == dimension - boxDimension {
                x += 1
                y = 0
                if x >= dimension {
                    return true
                }
            }
        }
        
        for number in 1 ... dimension {
            if isSafe(number: number, row: x, col: y) {
                solution[x][y] = number
                if fillRemaining(i: x, j: y + 1) {
                    return true
                }
                solution[x][y] = 0
            }
        }
        
        return false
    }

    func printBoard(board: [[Int]]) {
        for x in 0 ..< board.count {
            for y in 0 ..< board.count {
                print("\(board[x][y])", terminator: " ")
            }
            print()
        }
    }

    func removeNumbers(k: Int) {
        var missingNumbers = k
        while missingNumbers != 0 {
            let row = random - 1
            let col = random - 1
            if problem[row][col] != 0 {
                problem[row][col] = 0
                missingNumbers -= 1
            }
        }
    }

//    let time = Date()
    fillDiagonal()
    let _ = fillRemaining(i: 0, j: boxDimension)
//    printBoard(board: solution)
//    print(Date().timeIntervalSince(time))

    problem = solution
    removeNumbers(k: missingNumbers)
//    printBoard(board: problem)
    
    return Sudoku(solution: solution, problem: problem)
}
