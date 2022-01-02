//
//  GridView.swift
//  FGI
//
//  Created by user on 26.12.2021.
//

import UIKit

final class GridView: UIView {
    private var grid = CAShapeLayer()
    private var gridWidthMultiple: CGFloat = 0
    private var gridHeightMultiple: CGFloat = 10
    private var gridWidth: CGFloat {
        return bounds.width/CGFloat(gridWidthMultiple)
    }
    private var gridHeight: CGFloat {
        return bounds.height/CGFloat(gridHeightMultiple)
    }
    var countHandler: ((CGFloat) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.countHandler = { [weak self] number in
            self?.gridWidthMultiple = number
            self?.drawGrid(self?.bounds ?? frame)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GridView {
    func drawGrid(_ rect: CGRect) {
        let path = UIBezierPath()
        if self.gridWidthMultiple != 0 {
            for index in 1...Int(self.gridWidthMultiple) - 1 {
                let start = CGPoint(x: CGFloat(index) * self.gridWidth, y: 0)
                let end = CGPoint(x: CGFloat(index) * self.gridWidth, y:bounds.height)
                path.move(to: start)
                path.addLine(to: end)
            }
            for index in 1...Int(self.gridHeightMultiple) - 1 {
                let start = CGPoint(x: 0, y: CGFloat(index) * self.gridHeight)
                let end = CGPoint(x: bounds.width, y: CGFloat(index) * self.gridHeight)
                path.move(to: start)
                path.addLine(to: end)
            }
        }

        self.grid.path = path.cgPath
        self.grid.fillColor = UIColor.clear.cgColor
        self.grid.strokeColor = UIColor.gray.cgColor
        self.grid.lineWidth = 0.5
        self.grid.strokeEnd = 1.0
        self.layer.addSublayer(self.grid)
    }
}
