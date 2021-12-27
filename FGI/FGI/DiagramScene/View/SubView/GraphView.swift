//
//  GraphView.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import UIKit

final class GraphView: UIView {
    private var graphPoints = [Float]()
    private let graphLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    //private let grid = GridView()
    var pointHandler: (([Float]) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyGradient()
        //self.addSubview(self.grid)
        self.pointHandler = { [weak self] FGIes in
            self?.graphPoints = FGIes
            self?.drawLine(self?.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0))
        }
        //self.grid.countHandler?(CGFloat(self.graphPoints.count))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
        //self.grid.frame = self.bounds
    }
}

private extension GraphView {
    func drawLine(_ frame: CGRect) {
        let grid = GridView()
        grid.countHandler?(CGFloat(self.graphPoints.count - 1))
        grid.frame = frame
        
        let columnXpoint = { (clumn: Float) -> CGFloat in
            let spacing = frame.width / CGFloat(self.graphPoints.count - 1)
            return CGFloat(clumn) * spacing
        }
        let columnYpoint = { (graphPoint: Float) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(100.0) * frame.height
            return frame.height - y
        }
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXpoint(0), y: columnYpoint(self.graphPoints[0])))
        for (index, value) in self.graphPoints.enumerated() {
            let nextPoint = CGPoint(x: columnXpoint(Float(index)), y: columnYpoint(value))
            graphPath.addLine(to: nextPoint)
        }

        self.graphLayer.path = graphPath.cgPath
        self.graphLayer.fillColor = UIColor.clear.cgColor
        self.graphLayer.strokeColor = UIColor.black.cgColor
        self.graphLayer.lineWidth = 2.0
        self.graphLayer.strokeEnd = 1.0
        self.layer.addSublayer(self.graphLayer)
        self.addSubview(grid)
    }
    
    func applyGradient() {
        self.gradientLayer.colors = [UIColor.systemGreen.cgColor,
                                     UIColor.green.cgColor,
                                     UIColor.white.cgColor,
                                     UIColor.orange.cgColor,
                                     UIColor.red.cgColor]
        self.layer.addSublayer(self.gradientLayer)
    }
}
