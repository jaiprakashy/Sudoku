//
//  BoardView.swift
//  Sudoku
//
//  Created by Jaiprakash Yadav on 24/06/21.
//

import UIKit

class BoardView: UIView {
    
    var rows: Int = 9
    var cols: Int = 9
    var originX: CGFloat = 0.0
    var originY: CGFloat = 0.0
    var cellSize: CGFloat = 40.0
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        drawGrid()
    }
    
    func drawGrid() {
        let gridPath = UIBezierPath()
        gridPath.lineWidth = 2.0
        
        for row in 0 ... rows {
            gridPath.move(to: CGPoint(x: originX, y: originY + CGFloat(row) * cellSize))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(cols) * cellSize, y: originY + CGFloat(row) * cellSize))
        }
        
        for col in 0 ... cols {
            gridPath.move(to: CGPoint(x: originX + CGFloat(col) * cellSize, y: originY))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(col) * cellSize, y: originY + CGFloat(rows) * cellSize))
        }
        
        UIColor.black.setStroke()
        gridPath.stroke()
    }
}
