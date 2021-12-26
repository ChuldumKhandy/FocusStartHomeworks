//
//  GraphView.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import UIKit

final class GraphView: UIView {
    private var graphPoints: [Float] = [50.5, 45.6, 67, 45.4, 53.5, 77.7, 23.5, 89.8, 23.4, 89.0, 100.0, 34.5, 1.3]
    private let graphLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private let grid = GridView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyGradient()
        self.addSubview(self.grid)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
        self.drawLine(self.bounds)
        self.grid.frame = self.bounds
    }
    
    
}

private extension GraphView {
    func drawLine(_ frame: CGRect) {
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
    }
    
    func applyGradient() {
        self.gradientLayer.colors = [UIColor.green.cgColor, UIColor.white.cgColor, UIColor.red.cgColor]
        self.layer.addSublayer(self.gradientLayer)
    }
}
