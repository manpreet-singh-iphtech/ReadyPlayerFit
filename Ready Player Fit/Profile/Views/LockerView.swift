//
//  LockerView.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 30/01/26.
//

import Foundation
import UIKit

class LockerView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var onArrowTapped: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let countContainer = UIView()
    private let countLabel = UILabel()
    private let arrowIcon = UIImageView()
    private let actionButton = UIView()
    private let actionIcon = UIImageView()
    private let gridButton = UIView()
    private let infoButton = UIView()
    private let bottomBlurOverlay = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let gradientOverlay = CAGradientLayer()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let items = ["tshirt2", "hoodie1", "shoe3"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        setupUI()
        setupOverlays()
    }

    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientOverlay.frame = collectionView.bounds
    }
  
    private func setupUI() {
        
        titleLabel.text = "LOCKER"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16, weight: .black)
        
        countContainer.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        countContainer.layer.cornerRadius = 8
        countContainer.layer.borderWidth = 1
        countContainer.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        countContainer.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleArrowTap))
        countContainer.addGestureRecognizer(tap)
        
        countLabel.text = "9/9"
        countLabel.textColor = .white
        countLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        arrowIcon.image = UIImage(systemName: "chevron.right")
        arrowIcon.tintColor = .textGray
        arrowIcon.contentMode = .scaleAspectFit
        
        addSubview(collectionView)
        addSubview(bottomBlurOverlay)
        addSubview(titleLabel)
        addSubview(countContainer)
        addSubview(actionButton)
    
        actionButton.backgroundColor = .neonCyan
        actionButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
        actionButton.layer.cornerRadius = 12
        
        actionIcon.image = UIImage(systemName: "paperplane.fill")
        actionIcon.tintColor = .black
        actionIcon.contentMode = .scaleAspectFit
        
        [titleLabel, countContainer, collectionView, actionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        [countLabel, arrowIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            countContainer.addSubview($0)
        }
        
        [gridButton, infoButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        setupDiamondButton(gridButton, imageName: "square.grid.2x2.fill")
        setupDiamondButton(infoButton, imageName: "info.circle")
        
        actionIcon.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addSubview(actionIcon)
        
        collectionView.register(LockerCell.self, forCellWithReuseIdentifier: "LockerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        bottomBlurOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            countContainer.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            countContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countContainer.heightAnchor.constraint(equalToConstant: 35),
            countContainer.widthAnchor.constraint(equalToConstant: 75),
            
            countLabel.leadingAnchor.constraint(equalTo: countContainer.leadingAnchor, constant: 10),
            countLabel.centerYAnchor.constraint(equalTo: countContainer.centerYAnchor),
            
            arrowIcon.trailingAnchor.constraint(equalTo: countContainer.trailingAnchor, constant: -10),
            arrowIcon.centerYAnchor.constraint(equalTo: countContainer.centerYAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: 12),
          
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            gridButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            gridButton.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: 10),
            gridButton.widthAnchor.constraint(equalToConstant: 42),
            gridButton.heightAnchor.constraint(equalToConstant: 42),
            
            infoButton.leadingAnchor.constraint(equalTo: gridButton.trailingAnchor, constant: 20),
            infoButton.centerYAnchor.constraint(equalTo: gridButton.centerYAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 42),
            infoButton.heightAnchor.constraint(equalToConstant: 42),
          
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            actionButton.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: 10),
            actionButton.widthAnchor.constraint(equalToConstant: 42),
            actionButton.heightAnchor.constraint(equalToConstant: 42),
       
            actionIcon.centerXAnchor.constraint(equalTo: actionButton.centerXAnchor),
            actionIcon.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor),
            actionIcon.widthAnchor.constraint(equalToConstant: 20),
            actionIcon.heightAnchor.constraint(equalToConstant: 20),
        
            bottomBlurOverlay.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            bottomBlurOverlay.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            bottomBlurOverlay.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            bottomBlurOverlay.heightAnchor.constraint(equalTo: collectionView.heightAnchor, multiplier: 0.5)
        ])
   
        bringSubviewToFront(gridButton)
        bringSubviewToFront(infoButton)
        bringSubviewToFront(actionButton)
        actionIcon.transform = CGAffineTransform(rotationAngle: -.pi / 4)
    }
    
    private func setupDiamondButton(_ view: UIView, imageName: String) {
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 8
        view.transform = CGAffineTransform(rotationAngle: .pi / 4)
        
        let img = UIImageView(image: UIImage(systemName: imageName))
        img.tintColor = .white
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        
        view.addSubview(img)
        
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            img.widthAnchor.constraint(equalToConstant: 18),
            img.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupOverlays() {
        bottomBlurOverlay.isUserInteractionEnabled = false
        bottomBlurOverlay.alpha = 0.95
        
        let gradientView = UIView()
        gradientView.isUserInteractionEnabled = false
        insertSubview(gradientView, aboveSubview: collectionView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
     
        gradientOverlay.colors = [UIColor.clear.cgColor, UIColor.bgDark.cgColor]
        gradientOverlay.locations = [0.0, 1.0]
        gradientView.layer.addSublayer(gradientOverlay)
    }
    
    @objc private func handleArrowTap() {
        onArrowTapped?()
    }
    
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection s: Int) -> Int { items.count }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt ip: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "LockerCell", for: ip) as! LockerCell
        cell.configure(with: items[ip.item], isLocked: ip.item == 0)
        return cell
    }
    
    func collectionView(_ cv: UICollectionView, layout l: UICollectionViewLayout, sizeForItemAt ip: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    func collectionView(_ cv: UICollectionView, layout l: UICollectionViewLayout, insetForSectionAt s: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
