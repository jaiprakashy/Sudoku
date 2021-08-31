//
//  BoardView.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import UIKit

class BoardView: UIView {
    
    var dimension: Int = 9
    var originX: CGFloat = 0.0
    var originY: CGFloat = 0.0
    var cellSize: CGFloat = 40.0
    var shadowBoard: Board!
    var highlightView: UIView!
    var isFrozen: Bool = false
    let boxColor: UIColor = #colorLiteral(red: 0.5764705882, green: 0.7098039216, blue: 0.7764705882, alpha: 1)
    
    weak var delegate: BoardDelegate!

    override func draw(_ rect: CGRect) {
        // Drawing code
        removeAllSubViews()
        delegate.selectedPosition(position: nil)
        
        cellSize = bounds.width / CGFloat(dimension)
        drawBoxes()
        drawGrid()
        drawPieces()
    }
    
    func removeAllSubViews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func drawGrid() {
        let path = UIBezierPath()
        path.lineWidth = 1.3
        
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
    
    func drawBoxes() {
        var isDark = true
        let boxSide = bounds.width / 3
        let boxDimension = dimension / 3
        for row in 0 ..< boxDimension {
            for col in 0 ..< boxDimension {
                let boxPath = UIBezierPath(rect: CGRect(x: CGFloat(row) * boxSide, y: CGFloat(col) * boxSide, width: boxSide, height: boxSide))
                let color = isDark ? boxColor : boxColor.withAlphaComponent(0.65)
                color.setFill()
                boxPath.fill()
                isDark.toggle()
            }
        }
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
        guard !isFrozen else { return }
        
        let touch = touches.first!
        let location = touch.location(in: self)
                
        let row = Int((location.y - originY) / cellSize)
        let col = Int((location.x - originX) / cellSize)
        
        switch (row, col) {
        case(0 ..< dimension, 0 ..< dimension) :
            break
        default:
            return
        }
        
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
