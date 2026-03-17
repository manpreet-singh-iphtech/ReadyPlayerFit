//
//  AvatarEditorViewController.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 12/02/26.
//

import UIKit

final class AvatarEditorViewController: UIViewController {
    
    private let topNav = UIView()
    
    private let progressStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    private let avatarContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .cardGray.withAlphaComponent(0.8)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        return view
    }()
    
    private let platformView = OvalPlatformView()
    private let avatarImageView = UIImageView()
    
    private let controlsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let colorStack = UIStackView()
    private let subCategoryStack = UIStackView()
    private let adjustmentSlider = UISlider()
    private let mainCategoryStack = UIStackView()
    
    private let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .neonCyan
        btn.setTitle("SAVE AVATAR", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .cleanBody(size: 16, weight: .bold)
        btn.layer.cornerRadius = 14
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        setupSegmentedProgress()
        setupTopNavigation()
        setupAvatarPreview()
        setupControlPanel()
        setupBottomTabs()
    }
    
    private func setupBaseUI() {
        view.backgroundColor = .bgDark
        [topNav, progressStack, avatarContainer, controlsContainer, mainCategoryStack, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: mainCategoryStack.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupSegmentedProgress() {
        for i in 0..<2 {
            let segment = UIView()
            segment.backgroundColor = (i == 0 || i == 1) ? .neonCyan : .white.withAlphaComponent(0.1)
            segment.layer.cornerRadius = 1
            progressStack.addArrangedSubview(segment)
        }
        
        NSLayoutConstraint.activate([
            progressStack.topAnchor.constraint(equalTo: topNav.bottomAnchor, constant: 10),
            progressStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            progressStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            progressStack.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    private func setupTopNavigation() {
        let backBtn = UIButton(type: .system)
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.setTitle(" AVATAR", for: .normal)
        backBtn.tintColor = .white
        backBtn.titleLabel?.font = .cleanBody(size: 16, weight: .bold)
        backBtn.addTarget(self, action: #selector(dismissEditor), for: .touchUpInside)
        
        let skipBtn = UIButton(type: .system)
        skipBtn.setTitle("SKIP", for: .normal)
        skipBtn.setTitleColor(.textGray, for: .normal)
        skipBtn.titleLabel?.font = .cleanBody(size: 14, weight: .bold)
        skipBtn.addTarget(self, action: #selector(dismissEditor), for: .touchUpInside)
        
        [backBtn, skipBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            topNav.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            topNav.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topNav.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topNav.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topNav.heightAnchor.constraint(equalToConstant: 50),
            
            backBtn.leadingAnchor.constraint(equalTo: topNav.leadingAnchor, constant: 20),
            backBtn.centerYAnchor.constraint(equalTo: topNav.centerYAnchor),
            
            skipBtn.trailingAnchor.constraint(equalTo: topNav.trailingAnchor, constant: -20),
            skipBtn.centerYAnchor.constraint(equalTo: topNav.centerYAnchor)
        ])
    }
    
    private func setupAvatarPreview() {
        avatarContainer.addSubview(platformView)
        avatarContainer.addSubview(avatarImageView)
        platformView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageName = UserDefaults.standard.string(forKey: "equipped_avatar") ?? "avatar"
        avatarImageView.image = UIImage(named: imageName)
        avatarImageView.contentMode = .scaleAspectFit
        platformView.heightScale = 0.4
        
        NSLayoutConstraint.activate([
            avatarContainer.topAnchor.constraint(equalTo: progressStack.bottomAnchor, constant: 30),
            avatarContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            avatarContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.38),
            
            avatarImageView.centerXAnchor.constraint(equalTo: avatarContainer.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: avatarContainer.topAnchor, constant: 10),
            avatarImageView.heightAnchor.constraint(equalTo: avatarContainer.heightAnchor, multiplier: 0.85),
            
            platformView.centerXAnchor.constraint(equalTo: avatarContainer.centerXAnchor),
            platformView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -120),
            platformView.bottomAnchor.constraint(equalTo: avatarContainer.bottomAnchor, constant: -35),
            platformView.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    private func setupControlPanel() {
        [colorStack, subCategoryStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            controlsContainer.addSubview($0)
        }
        
        let sliderBox = UIView()
        sliderBox.backgroundColor = .white.withAlphaComponent(0.05)
        sliderBox.layer.borderWidth = 1
        sliderBox.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        sliderBox.layer.cornerRadius = 12
        sliderBox.translatesAutoresizingMaskIntoConstraints = false
        controlsContainer.addSubview(sliderBox)
        
        adjustmentSlider.translatesAutoresizingMaskIntoConstraints = false
        adjustmentSlider.minimumTrackTintColor = .neonCyan
        adjustmentSlider.maximumTrackTintColor = .white.withAlphaComponent(0.1)
        adjustmentSlider.setThumbImage(createSliderThumb(), for: .normal)
        sliderBox.addSubview(adjustmentSlider)
        
        colorStack.axis = .horizontal
        colorStack.distribution = .equalSpacing
        
        let colors: [UIColor] = [
            UIColor(hex: "#FFB39E"),
            UIColor(hex: "#F2A790"),
            UIColor(hex: "#E59B82"),
            UIColor(hex: "#D88F74"),
            UIColor(hex: "#CB8366"),
            UIColor(hex: "#BD7758")
        ]
        
        colors.forEach { color in
            let box = UIView()
            box.backgroundColor = .white.withAlphaComponent(0.05)
            box.layer.borderWidth = 1
            box.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            box.layer.cornerRadius = 10
            box.translatesAutoresizingMaskIntoConstraints = false
            
            let swatch = UIView()
            swatch.backgroundColor = color
            swatch.layer.cornerRadius = 10
            swatch.translatesAutoresizingMaskIntoConstraints = false
            
            if color == .systemOrange {
                box.layer.borderWidth = 1.5
                box.layer.borderColor = UIColor.neonCyan.cgColor
            }
            
            box.addSubview(swatch)
            colorStack.addArrangedSubview(box)
            
            NSLayoutConstraint.activate([
                box.widthAnchor.constraint(equalToConstant: 50),
                box.heightAnchor.constraint(equalToConstant: 50),
                swatch.centerXAnchor.constraint(equalTo: box.centerXAnchor),
                swatch.centerYAnchor.constraint(equalTo: box.centerYAnchor),
                swatch.widthAnchor.constraint(equalToConstant: 20),
                swatch.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
        
        subCategoryStack.axis = .horizontal
        subCategoryStack.distribution = .equalSpacing
        let subIcons = ["person.fill", "figure.stand.dress", "figure.dance", "figure.arms.open", "mustache.fill", "eyeglasses"]
        
        subIcons.forEach { icon in
            let box = UIView()
            box.backgroundColor = .white.withAlphaComponent(0.05)
            box.layer.cornerRadius = 10
            box.layer.borderWidth = 1
            box.layer.borderColor = (icon == "person.fill") ? UIColor.neonCyan.cgColor : UIColor.white.withAlphaComponent(0.1).cgColor
            box.translatesAutoresizingMaskIntoConstraints = false
            
            let img = UIImageView(image: UIImage(systemName: icon))
            img.tintColor = (icon == "person.fill") ? .white : .textGray
            img.translatesAutoresizingMaskIntoConstraints = false
            
            box.addSubview(img)
            subCategoryStack.addArrangedSubview(box)
            
            NSLayoutConstraint.activate([
                box.widthAnchor.constraint(equalToConstant: 50),
                box.heightAnchor.constraint(equalToConstant: 50),
                img.centerXAnchor.constraint(equalTo: box.centerXAnchor),
                img.centerYAnchor.constraint(equalTo: box.centerYAnchor),
                img.widthAnchor.constraint(equalToConstant: 24),
                img.heightAnchor.constraint(equalToConstant: 24)
            ])
        }
        
        NSLayoutConstraint.activate([
            controlsContainer.topAnchor.constraint(equalTo: avatarContainer.bottomAnchor, constant: 20),
            controlsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlsContainer.heightAnchor.constraint(equalToConstant: 180),
            
            colorStack.topAnchor.constraint(equalTo: controlsContainer.topAnchor, constant: 10),
            colorStack.heightAnchor.constraint(equalToConstant: 50),
            colorStack.leadingAnchor.constraint(equalTo: controlsContainer.leadingAnchor, constant: 35),
            colorStack.trailingAnchor.constraint(equalTo: controlsContainer.trailingAnchor, constant: -35),
            
            subCategoryStack.topAnchor.constraint(equalTo: colorStack.bottomAnchor, constant: 10),
            subCategoryStack.leadingAnchor.constraint(equalTo: controlsContainer.leadingAnchor, constant: 35),
            subCategoryStack.trailingAnchor.constraint(equalTo: controlsContainer.trailingAnchor, constant: -35),
            
            sliderBox.topAnchor.constraint(equalTo: subCategoryStack.bottomAnchor, constant: 10),
            sliderBox.leadingAnchor.constraint(equalTo: controlsContainer.leadingAnchor, constant: 30),
            sliderBox.trailingAnchor.constraint(equalTo: controlsContainer.trailingAnchor, constant: -30),
            sliderBox.heightAnchor.constraint(equalToConstant: 44),
            
            adjustmentSlider.centerYAnchor.constraint(equalTo: sliderBox.centerYAnchor),
            adjustmentSlider.leadingAnchor.constraint(equalTo: sliderBox.leadingAnchor, constant: 15),
            adjustmentSlider.trailingAnchor.constraint(equalTo: sliderBox.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupBottomTabs() {
        mainCategoryStack.axis = .horizontal
        mainCategoryStack.distribution = .equalSpacing
        mainCategoryStack.backgroundColor = .clear
            
        let icons = ["face.smiling", "eyebrow", "scissors", "nose", "mouth", "eye.fill"]
        
        icons.forEach { iconName in
            let box = UIView()
            box.backgroundColor = .white.withAlphaComponent(0.05)
            box.layer.borderWidth = 1
            box.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
            box.layer.cornerRadius = 12
            
            if iconName == "person.fill" {
                box.layer.borderWidth = 1.5
                box.layer.borderColor = UIColor.neonCyan.cgColor
            }
            
            let btn = UIButton(type: .system)
            btn.setImage(UIImage(systemName: iconName), for: .normal)
            btn.tintColor = (iconName == "person.fill") ? .white : .textGray
            btn.translatesAutoresizingMaskIntoConstraints = false
            
            box.addSubview(btn)
            NSLayoutConstraint.activate([
                box.widthAnchor.constraint(equalToConstant: 50),
                box.heightAnchor.constraint(equalToConstant: 50),
                
                btn.centerXAnchor.constraint(equalTo: box.centerXAnchor),
                btn.centerYAnchor.constraint(equalTo: box.centerYAnchor),
                btn.widthAnchor.constraint(equalToConstant: 24),
                btn.heightAnchor.constraint(equalToConstant: 24)
            ])
            
            mainCategoryStack.addArrangedSubview(box)
        }
            
        NSLayoutConstraint.activate([
            mainCategoryStack.topAnchor.constraint(equalTo: controlsContainer.bottomAnchor),
//            mainCategoryStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainCategoryStack.leadingAnchor.constraint(equalTo: subCategoryStack.leadingAnchor),
            mainCategoryStack.trailingAnchor.constraint(equalTo: subCategoryStack.trailingAnchor),
            mainCategoryStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createSliderThumb() -> UIImage {
        let size = CGSize(width: 12, height: 20)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            let rect = CGRect(origin: .zero, size: size)
            
            ctx.cgContext.setFillColor(UIColor.neonCyan.cgColor)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 2, y: 0))
            path.addLine(to: CGPoint(x: size.width, y: 0))
            path.addLine(to: CGPoint(x: size.width - 2, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
            path.close()
            
            ctx.cgContext.addPath(path.cgPath)
            ctx.cgContext.fillPath()
        }
    }
    
    @objc private func dismissEditor() {
        dismiss(animated: true)
    }
}

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = 6
        return newRect
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
