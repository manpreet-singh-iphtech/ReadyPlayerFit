//
//  OvalPlatformView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 30/01/26.
//

import Foundation
import UIKit

final class OvalPlatformView: UIView {
    
    private let ringLayer = CAShapeLayer()
    private let glowLayer = CAShapeLayer()
    private let fillLayer = CAGradientLayer()
    private let glowMaskLayer = CAGradientLayer()
    
    var heightScale: CGFloat = 1.5 {
        didSet { setNeedsLayout() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawEllipse()
    }
    
    private func setupLayers() {
        layer.addSublayer(fillLayer)
        layer.addSublayer(glowLayer)
        layer.addSublayer(ringLayer)
        
        fillLayer.colors = [
            UIColor.neonCyan.withAlphaComponent(0.35).cgColor,
            UIColor.neonCyan.withAlphaComponent(0.05).cgColor
        ]
        fillLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        fillLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        ringLayer.fillColor = UIColor.clear.cgColor
        ringLayer.strokeColor = UIColor.neonCyan.cgColor
        ringLayer.lineWidth = 2
        
        glowLayer.fillColor = UIColor.clear.cgColor
        glowLayer.strokeColor = UIColor.neonCyan.cgColor
        glowLayer.lineWidth = 6
        glowLayer.shadowOffset = CGSize(width: 0, height: 8)
        
        glowLayer.mask = glowMaskLayer
    }
    
    private func drawEllipse() {
        
        let widthInset: CGFloat = 1.5
        
        let safeHeightScale = min(heightScale, 1.5)
        let ellipseHeight = bounds.height * safeHeightScale
        
        let rect = CGRect(
            x: widthInset,
            y: bounds.height - ellipseHeight + 7,
            width: bounds.width - widthInset * 2,
            height: ellipseHeight
        )
        
        let path = UIBezierPath(ovalIn: rect)
        
        ringLayer.path = path.cgPath
        glowLayer.path = path.cgPath
        glowLayer.shadowPath = path.cgPath
        
        fillLayer.frame = bounds
        fillLayer.mask = ringLayer
        
        glowMaskLayer.frame = rect
        glowMaskLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.cgColor
        ]
        glowMaskLayer.locations = [0.45, 1.0]
        glowMaskLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        glowMaskLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}
