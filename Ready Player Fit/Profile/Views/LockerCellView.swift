//
//  LockerCellView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

class LockerCell: UICollectionViewCell {
    
    private let iconView = UIImageView()
    private let overlayContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.03)
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.05).cgColor
        
        iconView.contentMode = .scaleAspectFit
        iconView.alpha = 0.4
        
        [iconView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            iconView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with imageName: String, isLocked: Bool) {
        iconView.image = UIImage(named: imageName)
        iconView.alpha = isLocked ? 0.3 : 1.0
    }
}
