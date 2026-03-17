//
//  WorkoutViewController.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

final class WorkoutViewController: UIViewController {
    
    private let muscles: [(name: String, asset: String)] = [
        (name: "Chest", asset: "chest"),
        (name: "Abs", asset: "abs"),
        (name: "Trapezius", asset: "trapezius"),
        (name: "Upper back", asset: "upperBack"),
        (name: "Lower back", asset: "lowerBack")
    ]
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let bottomContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()

    private let navigationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgDark
        setupNavigationHeader()
        setupTableView()
        setupFooter()
    }
    
    private func setupNavigationHeader() {
        view.addSubview(navigationStack)
        
        let backLabel = UILabel()
        backLabel.text = "PERSONAL INFO"
        backLabel.textColor = .white
        backLabel.font = .systemFont(ofSize: 24, weight: .bold)
   
        navigationStack.addArrangedSubview(backLabel)
        
        navigationStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            navigationStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            navigationStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            navigationStack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MuscleTableViewCell.self, forCellReuseIdentifier: MuscleTableViewCell.identifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let header = WorkoutHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 280))
        tableView.tableHeaderView = header
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
    
    private func setupFooter() {
        let nextBtn = createButton(title: "NEXT", bg: .neonCyan, text: .black)
        nextBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
        view.addSubview(bottomContainer)
        bottomContainer.addArrangedSubview(nextBtn)
        
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            bottomContainer.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createButton(title: String, bg: UIColor, text: UIColor) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(text, for: .normal)
        btn.backgroundColor = bg
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.layer.cornerRadius = 8
        return btn
    }
    
    @objc private func didTapNext() {
        let injuryVC = InjurySelectionViewController()
        injuryVC.modalPresentationStyle = .fullScreen
        self.present(injuryVC, animated: true, completion: nil)
    }
}

extension WorkoutViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muscles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MuscleTableViewCell.identifier, for: indexPath) as! MuscleTableViewCell
        
        let muscleData = muscles[indexPath.row]
        cell.configure(with: muscleData.name, imageName: muscleData.asset)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "TORSO (5)"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }
}
