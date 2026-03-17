//
//  StartRingView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit
import QuartzCore

class CircularStatView: UIView {
    private let shapeLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private let iconImageView = UIImageView()
    private let lvlLabel = UILabel()
    private var targetProgress: CGFloat = 0

    init(icon: String, level: Int, progress: CGFloat) {
        self.targetProgress = progress
        super.init(frame: .zero)
        setupView(icon: icon, level: level)
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupView(icon: String, level: Int) {
        let center = CGPoint(x: 35, y: 35)
        let circularPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: -.pi / 2, endAngle: 1.5 * .pi, clockwise: true)

        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.white.withAlphaComponent(0.1).cgColor
        trackLayer.lineWidth = 3
        trackLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(trackLayer)

        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.neonCyan.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        
        shapeLayer.shadowColor = UIColor.neonCyan.cgColor
        shapeLayer.shadowRadius = 5
        shapeLayer.shadowOpacity = 0.8
        shapeLayer.shadowOffset = .zero
        layer.addSublayer(shapeLayer)

        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = .neonCyan
        iconImageView.contentMode = .scaleAspectFit
        
        lvlLabel.text = "LVL \(level)"
        lvlLabel.font = .systemFont(ofSize: 10, weight: .bold)
        lvlLabel.textColor = .textGray

        let stack = UIStackView(arrangedSubviews: [iconImageView, lvlLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .center
        addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func animateProgress() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = targetProgress
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        shapeLayer.strokeEnd = targetProgress
        shapeLayer.add(animation, forKey: "progressAnim")
    }
}
