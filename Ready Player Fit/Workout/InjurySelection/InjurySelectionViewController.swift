//
//  InjurySelectionViewController.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 17/02/26.
//

import UIKit

final class InjurySelectionViewController: UIViewController {
    
    private let topNavContainer = UIView()
    
    private let progressStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "DO YOU HAVE ANY INJURIES OR PHYSICAL LIMITATIONS?"
        l.numberOfLines = 0
        l.textColor = .white
        l.font = .systemFont(ofSize: 22, weight: .bold)
        return l
    }()
    
    private let subLabel: UILabel = {
        let l = UILabel()
        l.text = "Choose the body part where you are experiencing discomfort or an injury."
        l.numberOfLines = 0
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    
    private let bodyMapContainer: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 1.0, alpha: 0.05)
        v.layer.cornerRadius = 20
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        return v
    }()

    private let bodyImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "body_front")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        return iv
    }()
    
    private let toggleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        stack.layer.cornerRadius = 8
        stack.clipsToBounds = true
        return stack
    }()
    
    private let bottomButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.05, green: 0.07, blue: 0.1, alpha: 1.0)
        setupUI()
        setupTopNavigation()
        setupBodyToggle()
        setupFooter()
    }
    
    private func setupUI() {
        [topNavContainer, progressStack, titleLabel, subLabel, bodyMapContainer, bottomButtonStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        bodyMapContainer.addSubview(bodyImageView)
        bodyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        setupProgressSegments()
        
        NSLayoutConstraint.activate([
            topNavContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topNavContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topNavContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topNavContainer.heightAnchor.constraint(equalToConstant: 44),
            
            progressStack.topAnchor.constraint(equalTo: topNavContainer.bottomAnchor, constant: 10),
            progressStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressStack.heightAnchor.constraint(equalToConstant: 4),
            
            titleLabel.topAnchor.constraint(equalTo: progressStack.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            bodyMapContainer.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 25),
            bodyMapContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bodyMapContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bodyMapContainer.bottomAnchor.constraint(equalTo: bottomButtonStack.topAnchor, constant: -30),
            
            bodyImageView.centerXAnchor.constraint(equalTo: bodyMapContainer.centerXAnchor),
            bodyImageView.centerYAnchor.constraint(equalTo: bodyMapContainer.centerYAnchor, constant: -30),
            bodyImageView.heightAnchor.constraint(equalTo: bodyMapContainer.heightAnchor, multiplier: 0.85),
            
            bottomButtonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomButtonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomButtonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomButtonStack.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func setupTopNavigation() {
        let backBtn = UIButton(type: .system)
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.tintColor = .white
        
        let navTitle = UILabel()
        navTitle.text = "PERSONAL INFO"
        navTitle.textColor = .white
        navTitle.font = .systemFont(ofSize: 18, weight: .bold)
        
        let stepView = UIView()
        stepView.layer.borderWidth = 1
        stepView.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        stepView.layer.cornerRadius = 4
        
        let skipBtn = UIButton(type: .system)
        skipBtn.setTitle("SKIP", for: .normal)
        skipBtn.setTitleColor(.lightGray, for: .normal)
        skipBtn.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
        
        [backBtn, navTitle, stepView, skipBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            topNavContainer.addSubview($0)
        }
        
        topNavContainer.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        topNavContainer.addGestureRecognizer(tapGesture)
        
        backBtn.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: topNavContainer.leadingAnchor, constant: 20),
            backBtn.centerYAnchor.constraint(equalTo: topNavContainer.centerYAnchor),
            
            navTitle.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 10),
            navTitle.centerYAnchor.constraint(equalTo: topNavContainer.centerYAnchor),
            
            skipBtn.trailingAnchor.constraint(equalTo: topNavContainer.trailingAnchor, constant: -20),
            skipBtn.centerYAnchor.constraint(equalTo: topNavContainer.centerYAnchor)
        ])
    }
    
    @objc private func handleBackTap() {
        if isBeingPresented || navigationController == nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupBodyToggle() {
        let frontBtn = createToggleBtn(title: "FRONT", isSelected: true)
        let backBtn = createToggleBtn(title: "BACK", isSelected: false)
        
        frontBtn.tag = 0
        backBtn.tag = 1
        
        frontBtn.addTarget(self, action: #selector(handleToggleTap(_:)), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(handleToggleTap(_:)), for: .touchUpInside)
        
        bodyMapContainer.addSubview(toggleStack)
        toggleStack.translatesAutoresizingMaskIntoConstraints = false
        toggleStack.addArrangedSubview(frontBtn)
        toggleStack.addArrangedSubview(backBtn)
        
        NSLayoutConstraint.activate([
            toggleStack.bottomAnchor.constraint(equalTo: bodyMapContainer.bottomAnchor, constant: -20),
            toggleStack.centerXAnchor.constraint(equalTo: bodyMapContainer.centerXAnchor),
            toggleStack.widthAnchor.constraint(equalToConstant: 160),
            toggleStack.heightAnchor.constraint(equalToConstant: 35),
            frontBtn.widthAnchor.constraint(equalTo: toggleStack.widthAnchor, multiplier: 0.5)
        ])
    }
    
    @objc private func handleToggleTap(_ sender: UIButton) {
        let imageName = (sender.tag == 0) ? "body_front" : "body_back"
        bodyImageView.image = UIImage(named: imageName)
        
        toggleStack.arrangedSubviews.forEach { subview in
            if let btn = subview as? UIButton {
                let isSelected = (btn == sender)
                btn.setTitleColor(isSelected ? .white : .gray, for: .normal)
                btn.backgroundColor = isSelected ? UIColor.white.withAlphaComponent(0.1) : .clear
            }
        }
    }
    
    private func setupFooter() {
        let backBtn = createActionBtn(title: "BACK", color: UIColor(white: 1.0, alpha: 0.1), textColor: .lightGray)
        backBtn.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
        let finishBtn = createActionBtn(title: "FINISH", color: UIColor.cyan, textColor: .black)
        
        bottomButtonStack.addArrangedSubview(backBtn)
        bottomButtonStack.addArrangedSubview(finishBtn)
    }
    
    private func createToggleBtn(title: String, isSelected: Bool) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        btn.setTitleColor(isSelected ? .white : .gray, for: .normal)
        btn.backgroundColor = isSelected ? UIColor.white.withAlphaComponent(0.1) : .clear
        return btn
    }
    
    private func createActionBtn(title: String, color: UIColor, textColor: UIColor) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = color
        btn.setTitleColor(textColor, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.layer.cornerRadius = 14
        return btn
    }
    
    private func setupProgressSegments() {
        for i in 0..<8 {
            let segment = UIView()
            segment.backgroundColor = i < 7 ? UIColor.cyan : UIColor.white.withAlphaComponent(0.1)
            segment.layer.cornerRadius = 2
            progressStack.addArrangedSubview(segment)
        }
    }
    
    func processBodyImage(image: UIImage) -> UIImage? {
        let size = image.size
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        
        let rect = CGRect(origin: .zero, size: size)
        UIColor(white: 1.0, alpha: 0.05).setFill()
        UIRectFill(rect)
        
        image.draw(in: rect)
        
        let processedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return processedImage
    }
}
