//
//  LockerDetailViewController.swift
//  Ready Player Fit
//
//  Created by Manpreet Singh on 01/02/26.
//

import Foundation
import UIKit

class LockerDetailViewController: UIViewController {
    
    private let navBar = UIView()
    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let countLabel = UILabel()
    private let resetButton = UIButton()
    
    private let alertView = UIStackView()
    private let alertLabel = UILabel()
    private let OKButton = UIButton(type: .system)
    
    private let categoryStack = UIStackView()
    private let avatarImageView = UIImageView()
    private let platformView = OvalPlatformView()
    
    private let equipButton = UIButton(type: .system)
    
    var onEquipSelected: ((String) -> Void)?
    private var lastSelectedImageName: String = UserDefaults.standard.string(forKey: "equipped_avatar") ?? "avatar"
    
    private var selectedCategory: LockerCategory = .tshirt
    
    private var equippedTopID: String?
    private var equippedShoeID: String?

    private var filteredItems: [LockerItem] {
        return allItems.filter { $0.category == selectedCategory }
    }
    
    private let categories = ["TSHIRT", "HOODIE", "SHOES"]
    
    private var allItems: [LockerItem] = [
        
        LockerItem(name: "Tshirt 1", image: "tshirt1", desc: "5 lb / 1 rep", category: .tshirt),
        LockerItem(name: "Tshirt 2", image: "tshirt2", desc: "6 lb / 2 rep", category: .tshirt),
        LockerItem(name: "Tshirt 3", image: "tshirt3", desc: "7 lb / 3 rep", category: .tshirt),
        
        LockerItem(name: "Hoodie 1", image: "hoodie1", desc: "10 lb / 1 rep", category: .hoodie),
        LockerItem(name: "Hoodie 2", image: "hoodie2", desc: "12 lb / 2 rep", category: .hoodie),
        LockerItem(name: "Hoodie 3", image: "hoodie3", desc: "15 lb / 3 rep", category: .hoodie),
        
        LockerItem(name: "Shoes 1", image: "shoe1", desc: "20 lb / 1 rep", category: .shoes),
        LockerItem(name: "Shoes 2", image: "shoe2", desc: "22 lb / 2 rep", category: .shoes),
        LockerItem(name: "Shoes 3", image: "shoe3", desc: "25 lb / 3 rep", category: .shoes),
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 7
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(LockerItemCell.self, forCellWithReuseIdentifier: "LockerItemCell")
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgDark
        
        let savedName = UserDefaults.standard.string(forKey: "equipped_avatar") ?? "avatar"
        syncStateFromSavedImage(savedName)
        
        setupUI()
        setUpAlert()
        
        if let tshirtBtn = categoryStack.arrangedSubviews[0] as? CategoryPillButton {
            categoryDidTap(tshirtBtn)
        }
    }
    
    private func setupUI() {
        setupNav()
        
        categoryStack.axis = .horizontal
        categoryStack.spacing = 10
        categoryStack.distribution = .fillProportionally
        view.addSubview(categoryStack)
        
        for (index, cat) in categories.enumerated() {
            let btn = CategoryPillButton(title: cat)
            btn.addTarget(self, action: #selector(categoryDidTap(_:)), for: .touchUpInside)
            categoryStack.addArrangedSubview(btn)
        }
        
        let imageName = UserDefaults.standard.string(forKey: "equipped_avatar") ?? "avatar"
        avatarImageView.image = UIImage(named: imageName)
        avatarImageView.contentMode = .scaleAspectFit
        
        equipButton.backgroundColor = .neonCyan
        equipButton.setTitle("EQUIP TO AVATAR", for: .normal)
        equipButton.setTitleColor(.black, for: .normal)
        equipButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        equipButton.layer.cornerRadius = 12
        equipButton.addTarget(self, action: #selector(didTapEquip), for: .touchUpInside)
        
        [categoryStack, platformView, avatarImageView, collectionView, equipButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            categoryStack.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 15),
            categoryStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryStack.heightAnchor.constraint(equalToConstant: 36),
            
            avatarImageView.topAnchor.constraint(equalTo: categoryStack.bottomAnchor, constant: 15),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            platformView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -45),
            platformView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            platformView.widthAnchor.constraint(equalToConstant: 280),
            platformView.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: platformView.bottomAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 180),
            
            equipButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            equipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            equipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            equipButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNav() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        titleLabel.text = "LOCKER"
        titleLabel.font = .systemFont(ofSize: 20, weight: .black)
        titleLabel.textColor = .white
        
        resetButton.backgroundColor = .neonCyan
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        resetButton.layer.cornerRadius = 12
        resetButton.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
        
        [backButton, titleLabel, resetButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            navBar.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 50),
            
            backButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            
            resetButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20),
            resetButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 35),
            resetButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setUpAlert() {
        alertView.axis = .vertical
        alertView.alignment = .center
        alertView.backgroundColor = UIColor.neonCyan.withAlphaComponent(0.16)
        alertView.layer.borderWidth = 1
        alertView.layer.borderColor = UIColor.neonCyan.withAlphaComponent(0.16).cgColor
        alertView.layer.cornerRadius = 16
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.isHidden = true

        alertLabel.text = "Equipped Successfully"
        alertLabel.textColor = .white
        alertLabel.font = .systemFont(ofSize: 16, weight: .medium)
        alertLabel.textAlignment = .center
        alertLabel.translatesAutoresizingMaskIntoConstraints = false

        OKButton.setTitle("OK", for: .normal)
        OKButton.setTitleColor(.black, for: .normal)
        OKButton.backgroundColor = .neonCyan
        OKButton.layer.cornerRadius = 10
        OKButton.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        OKButton.translatesAutoresizingMaskIntoConstraints = false
        OKButton.addTarget(self, action: #selector(didTapOK), for: .touchUpInside)

        view.addSubview(alertView)
        alertView.addSubview(alertLabel)
        alertView.addSubview(OKButton)

        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 220),
            alertView.heightAnchor.constraint(equalToConstant: 100),
            
            alertLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 5),
            alertLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            alertLabel.heightAnchor.constraint(equalToConstant: 40),
            alertLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),

            OKButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            OKButton.widthAnchor.constraint(equalToConstant: 100),
            OKButton.heightAnchor.constraint(equalToConstant: 35),
            OKButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -15)
        ])
    }
    
    private func showAlert() {
        alertView.alpha = 0
        alertView.isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.alertView.alpha = 1
        }
    }
    
    @objc private func didTapOK() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.alpha = 0
        }) { _ in
            self.alertView.isHidden = true
        }
    }

    @objc private func categoryDidTap(_ sender: CategoryPillButton) {
        categoryStack.arrangedSubviews.forEach { ($0 as? UIButton)?.isSelected = false }
        sender.isSelected = true
        
        guard let title = sender.titleLabel?.text,
              let category = LockerCategory(rawValue: title) else { return }
        
        selectedCategory = category
        collectionView.reloadData()
    }
    
    @objc private func didTapBack() {
        dismiss(animated: true)
    }
    
    
    @objc private func didTapReset() {
        lastSelectedImageName = "avatar"
        UserDefaults.standard.set(lastSelectedImageName, forKey: "equipped_avatar")
        avatarImageView.image = UIImage(named: "avatar")
        syncStateFromSavedImage(lastSelectedImageName)
        self.showAlert()
    }
    
    @objc private func didTapEquip() {
        UserDefaults.standard.set(lastSelectedImageName, forKey: "equipped_avatar")
        syncStateFromSavedImage(lastSelectedImageName)
        onEquipSelected?(lastSelectedImageName)
        self.showAlert()
    }
    
    private func constructName(top: String?, shoe: String?) -> String {
        switch (top, shoe) {
        case let (t?, s?): return "avatar_\(t)_\(s)"
        case let (t?, nil): return "avatar_\(t)"
        case let (nil, s?): return "avatar_\(s)"
        default: return "avatar"
        }
    }
    
    private func syncStateFromSavedImage(_ name: String) {
        equippedTopID = nil
        equippedShoeID = nil
        
        let components = name.components(separatedBy: "_")
        for component in components {
            if component.contains("tshirt") || component.contains("hoodie") {
                equippedTopID = component
            } else if component.contains("shoe") {
                equippedShoeID = component
            }
        }
    }
}

extension LockerDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection s: Int) -> Int {
        filteredItems.count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt ip: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "LockerItemCell", for: ip) as! LockerItemCell
        let item = filteredItems[ip.item]
        cell.configure(with: item.image, title: item.name, subtitle: item.desc)
        return cell
    }
    
    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = filteredItems[indexPath.item]
        let previewName: String

        if selectedCategory == .shoes {
            previewName = constructName(top: equippedTopID, shoe: item.image)
        } else {
            previewName = constructName(top: item.image, shoe: equippedShoeID)
        }
        
        print("Previewing: \(previewName)")
        
        if let image = UIImage(named: previewName) {
            avatarImageView.image = image
            lastSelectedImageName = previewName
        } else {
            print("Missing Asset: \(previewName)")
        }
    }
    
    func collectionView(_ cv: UICollectionView, layout l: UICollectionViewLayout, sizeForItemAt ip: IndexPath) -> CGSize {
        let totalHorizontalPadding: CGFloat = 40
        let totalSpacing: CGFloat = 14
        let availableWidth = UIScreen.main.bounds.width - totalHorizontalPadding - totalSpacing
        let itemWidth = availableWidth / 3
        
        return CGSize(width: itemWidth, height: 210)
    }
    
    func collectionView(_ cv: UICollectionView, layout l: UICollectionViewLayout, insetForSectionAt s: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
