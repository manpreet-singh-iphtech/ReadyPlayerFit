//
//  HistoryViewController.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

struct Muscle {
    let name: String
    let assetName: String
}

struct WorkoutData {
    let date: String
    let title: String
    let exercises: String
    let muscles: [Muscle]
}

final class HistoryViewController: UIViewController {
    
    private var selectedToggleIndex = 0
    private let gridTab = UIView()
    private let listTab = UIView()
    private let gridIcon = UIImageView(image: UIImage(systemName: "square.grid.2x2.fill"))
    private let listIcon = UIImageView(image: UIImage(systemName: "list.bullet.rectangle.portrait.fill"))
    
    private let workoutList = [

        WorkoutData(
            date: "11/4/24",
            title: "Glutes, Chest & Legs",
            exercises: "Hip Thrust • Cycling - Stationary • Barbell Decline Bench Press • Push Ups • Incline Push Up • Superman Hold",
            muscles: [
                Muscle(name: "Quadriceps", assetName: "quadriceps"),
                Muscle(name: "Glutes", assetName: "glutes"),
                Muscle(name: "Chest", assetName: "chest"),
                Muscle(name: "Lower Back", assetName: "lowerBack")
            ]
        ),

        WorkoutData(
            date: "11/2/24",
            title: "Legs & Core Blast",
            exercises: "Jog In Place • Air Squats • Lunge Jump • Bicycle Crunch • Superman Hold • Crunches",
            muscles: [
                Muscle(name: "Calves", assetName: "calves"),
                Muscle(name: "Quadriceps", assetName: "quadriceps"),
                Muscle(name: "Abs", assetName: "abs"),
                Muscle(name: "Lower Back", assetName: "lowerBack")
            ]
        )
    ]
    
    private let tableView = UITableView()
    
    private let toggleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .cardGray
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        return view
    }()
    
    private let fabButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .neonCyan
        btn.layer.cornerRadius = 12
        btn.tintColor = .black
        
        btn.transform = CGAffineTransform(rotationAngle: .pi / 4)
        
        let icon = UIImageView(image: UIImage(systemName: "plus"))
        icon.tintColor = .black
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        icon.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        
        btn.addSubview(icon)
        
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .bgDark
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkoutHistoryCell.self, forCellReuseIdentifier: "WorkoutCell")
        
        let header = HistoryHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
        tableView.tableHeaderView = header
        
        view.addSubview(tableView)
        view.addSubview(toggleContainer)
        view.addSubview(fabButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        toggleContainer.translatesAutoresizingMaskIntoConstraints = false
        fabButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            toggleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            toggleContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            toggleContainer.widthAnchor.constraint(equalToConstant: 80),
            toggleContainer.heightAnchor.constraint(equalToConstant: 45),
            
            fabButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            fabButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            fabButton.widthAnchor.constraint(equalToConstant: 45),
            fabButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        setupToggleContent()
    }
    
    private func setupToggleContent() {
        let tabs = [gridTab, listTab]
        let icons = [gridIcon, listIcon]
        
        let stack = UIStackView(arrangedSubviews: tabs)
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        toggleContainer.addSubview(stack)
        
        for (index, tab) in tabs.enumerated() {
            tab.layer.cornerRadius = 8
            tab.layer.borderWidth = 0
            tab.isUserInteractionEnabled = true
            tab.tag = index
            
            let icon = icons[index]
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            tab.addSubview(icon)
            
            NSLayoutConstraint.activate([
                icon.centerXAnchor.constraint(equalTo: tab.centerXAnchor),
                icon.centerYAnchor.constraint(equalTo: tab.centerYAnchor),
                icon.widthAnchor.constraint(equalToConstant: 20),
                icon.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(toggleTapped(_:)))
            tab.addGestureRecognizer(tap)
        }
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: toggleContainer.topAnchor),
            stack.bottomAnchor.constraint(equalTo: toggleContainer.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: toggleContainer.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: toggleContainer.trailingAnchor)
        ])
        
        updateToggleUI()
    }
    
    @objc private func toggleTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedView = gesture.view else { return }
        selectedToggleIndex = tappedView.tag
        updateToggleUI()
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    private func updateToggleUI() {
        let tabs = [gridTab, listTab]
        let icons = [gridIcon, listIcon]
        
        for (index, tab) in tabs.enumerated() {
            let isSelected = (index == selectedToggleIndex)
            
            tab.layer.borderWidth = isSelected ? 1.5 : 0
            tab.layer.borderColor = isSelected ? UIColor.neonCyan.cgColor : UIColor.clear.cgColor
            
            icons[index].tintColor = isSelected ? .white : .textGray
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutHistoryCell
        let data = workoutList[indexPath.row]
        cell.configure(
            date: data.date,
            title: data.title,
            exercises: data.exercises,
            muscles: data.muscles
        )
        return cell
    }
}
