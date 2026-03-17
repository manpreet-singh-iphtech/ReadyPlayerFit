//
//  AvatarView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

final class AvatarView: UIView {

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        let imageName = UserDefaults.standard.string(forKey: "equipped_avatar") ?? "avatar"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit

        addSubview(imageView)
        imageView.frame = bounds
    }
    
    func refreshAvatar() {
        let imageName = UserDefaults.standard.string(forKey: "equipped_avatar") ?? "avatar"
        imageView.image = UIImage(named: imageName)
        print("image Name \(imageName)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }

    func startAnimation() {
        float()
    }
}
