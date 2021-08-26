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
    var shadowBoard: Board!
    var highlightView: UIView!
    
    weak var delegate: BoardDelegate!

    override func draw(_ rect: CGRect) {
        // Drawing code
        removeAllSubViews()
        delegate.selectedPosition(position: nil)
        
        cellSize = bounds.width / CGFloat(dimension)
        drawBoard()
        drawPieces()
    }
    
    func removeAllSubViews() {
        subviews.forEach({ $0.removeFromSuperview() })
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
                let numberPiece = shadowBoard[Position(row: row, col: col)]
                guard numberPiece != NumberPiece.emptyPiece else {
                    continue
                }
                drawLabel(atRow: row, atCol: col, withNumberPiece: numberPiece)
            }
        }
    }
    
    func drawLabel(atRow row: Int, atCol col: Int, withNumberPiece piece: NumberPiece) {
        let label = UILabel(frame: CGRect(x: originX + CGFloat(col) * cellSize, y: originY + CGFloat(row) * cellSize, width: cellSize, height: cellSize))
        label.text = piece.stringValue()
        label.textAlignment = .center
        label.font = piece.isStatic ? UIFont.boldSystemFont(ofSize: 22.0) : UIFont.systemFont(ofSize: 22.0)
        label.textColor = piece.isStatic ? .black : .blue
        addSubview(label)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        let row = Int((location.y - originY) / cellSize)
        let col = Int((location.x - originX) / cellSize)
        
        print(row, col)
        highlightCell(at: Position(row: row, col: col))
    }
    
    func highlightCell(at position: Position) {
        highlightView?.removeFromSuperview()
        guard delegate.canHighlight(at: position) else {
            delegate.selectedPosition(position: nil)
            return
        }
        
        highlightView = generateHighlightView(frame: CGRect(x: originX + CGFloat(position.col) * cellSize, y: originY + CGFloat(position.row) * cellSize, width: cellSize, height: cellSize))
        addSubview(highlightView)
        
        delegate.selectedPosition(position: position)
    }
    
    func generateHighlightView(frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.blue.cgColor
        
        return view
    }
}
