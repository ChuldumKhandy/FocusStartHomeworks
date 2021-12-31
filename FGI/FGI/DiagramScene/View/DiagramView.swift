//
//  DiagramView.swift
//  FGI
//
//  Created by user on 24.12.2021.
//

import UIKit

protocol IDiagramView: UIView {
    func setFGI(fgi: [FGI])
}

final class DiagramView: UIView {
    private let graphView = GraphView()
    private let detailView = DetailTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubviews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DiagramView: IDiagramView {
    func setFGI(fgi: [FGI]) {
        self.graphView.pointHandler?(fgi.map { (fgi) -> Float in
            fgi.value
        })
        self.detailView.valueHandler?(fgi)
    }
}

private extension DiagramView {
    func addSubviews() {
        self.addSubview(self.graphView)
        self.addSubview(self.detailView)
    }
    
    func setConstraints() {
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        self.graphView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewConstraints.top.rawValue).isActive = true
        self.graphView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewConstraints.left.rawValue).isActive = true
        self.graphView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewConstraints.left.rawValue).isActive = true
        self.graphView.heightAnchor.constraint(equalToConstant: ViewConstraints.heightGraph.rawValue).isActive = true
        
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.topAnchor.constraint(equalTo: self.graphView.bottomAnchor, constant: ViewConstraints.marginSmall.rawValue).isActive = true
        self.detailView.leadingAnchor.constraint(equalTo: self.graphView.leadingAnchor).isActive = true
        self.detailView.trailingAnchor.constraint(equalTo: self.graphView.trailingAnchor).isActive = true
        self.detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ViewConstraints.bottom.rawValue).isActive = true
    }
}
