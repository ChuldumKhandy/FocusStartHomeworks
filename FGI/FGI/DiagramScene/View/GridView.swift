//
//  GridView.swift
//  FGI
//
//  Created by user on 26.12.2021.
//

import UIKit

final class GridView: UIView {
    private var path = UIBezierPath()
    private var gridWidthMultiple: CGFloat = 12 // self.graphPoints.count - 1
    private var gridHeightMultiple: CGFloat = 10
    private var gridWidth: CGFloat {
        return bounds.width/CGFloat(gridWidthMultiple)
    }
    private var gridHeight: CGFloat {
        return bounds.height/CGFloat(gridHeightMultiple)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.draw(frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.drawGrid()
        UIColor.gray.setStroke()
        self.path.stroke()
    }
}

private extension GridView {
    func drawGrid() {
        self.path.lineWidth = 0.5

        for index in 1...Int(self.gridWidthMultiple) - 1 {
            let start = CGPoint(x: CGFloat(index) * self.gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * self.gridWidth, y:bounds.height)
            self.path.move(to: start)
            self.path.addLine(to: end)
        }
        for index in 1...Int(self.gridHeightMultiple) - 1 {
            let start = CGPoint(x: 0, y: CGFloat(index) * self.gridHeight)
            let end = CGPoint(x: bounds.width, y: CGFloat(index) * self.gridHeight)
            self.path.move(to: start)
            self.path.addLine(to: end)
        }
        self.path.close()
    }
}
