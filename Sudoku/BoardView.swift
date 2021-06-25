//
//  BoardView.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import UIKit

class BoardView: UIView {
    
    var dimension: Int = 1
    var originX: CGFloat = 0.0
    var originY: CGFloat = 0.0
    var cellSize: CGFloat = 40.0
    var shadowBoard: Array<Array<NumberPiece>> = [[]]
    var selectedPosition: (row: Int, col: Int)?
    var highlightView: UIView!
    
    weak var delegate: BoardDelegate!

    override func draw(_ rect: CGRect) {
        // Drawing code
        dimension = shadowBoard.count
        cellSize = bounds.width / CGFloat(dimension)
        drawBoard()
        drawPieces()
    }
    
    func drawBoard() {
        let path = UIBezierPath()
        path.lineWidth = 2.0
        
        for row in 0 ... dimension {
            path.move(to: CGPoint(x: originX, y: originY + CGFloat(row) * cellSize))
            path.addLine(to: CGPoint(x: originX + CGFloat(dimension) * cellSize, y: originY + CGFloat(row) * cellSize))
        }
        
        for col in 0 ... dimension {
            path.move(to: CGPoint(x: originX + CGFloat(col) * cellSize, y: originY))
            path.addLine(to: CGPoint(x: originX + CGFloat(col) * cellSize, y: originY + CGFloat(dimension) * cellSize))
        }
        
        UIColor.black.setStroke()
        path.stroke()
    }
    
    func drawPieces() {
        for row in 0 ..< dimension {
            for col in 0 ..< dimension {
                let numberPiece = shadowBoard[row][col]
                drawLabel(atRow: row, atCol: col, withNumberPiece: numberPiece)
            }
        }
    }
    
    func drawLabel(atRow row: Int, atCol col: Int, withNumberPiece piece: NumberPiece) {
        let label = UILabel(frame: CGRect(x: originX + CGFloat(col) * cellSize, y: originY + CGFloat(row) * cellSize, width: cellSize, height: cellSize))
        label.text = piece.stringValue()
        label.textAlignment = .center
        label.font = piece.isStatic ? UIFont.boldSystemFont(ofSize: 22.0) : UIFont.systemFont(ofSize: 22.0)
        addSubview(label)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        let row = Int((location.y - originY) / cellSize)
        let col = Int((location.x - originX) / cellSize)
        
        print(row, col)
        if (row >= 0 && row <= 8) && (col >= 0 && col <= 8) {
            selectedPosition = (row, col)
        } else {
            selectedPosition = nil
        }
    }
}
