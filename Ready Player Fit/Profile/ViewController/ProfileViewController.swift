import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private let headerView = ProfileHeaderView()
    private let toggleControl = ProfileToggleButton()
    private let avatarImageView = UIImageView()
    private let platformView = OvalPlatformView()
    private let statsContainer = UIView()
    private let goalStreakView = GoalStreakView()
    private let lockerSection = LockerView()
    private var statRingViews: [CircularStatView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgDark
        setupLayout()
//        setupStatsGrid()
        setupToggleLogic()
        
        lockerSection.onArrowTapped = { [weak self] in
            let lockerVC = LockerDetailViewController()
            lockerVC.modalPresentationStyle = .fullScreen
            self?.present(lockerVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let savedAvatar = UserDefaults.standard.string(forKey: "equipped_avatar") ?? "avatar"
        print("viewWillAppear avatar image: \(savedAvatar)")
        avatarImageView.image = UIImage(named: savedAvatar)
        setupStatsGrid()
        statRingViews.forEach { $0.animateProgress() }
    }
    
    private func setupLayout() {
        [headerView, toggleControl, platformView, avatarImageView, statsContainer, goalStreakView, lockerSection].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        statsContainer.isUserInteractionEnabled = false
        avatarImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        avatarImageView.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            toggleControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            toggleControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toggleControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toggleControl.heightAnchor.constraint(equalToConstant: 45),

            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: toggleControl.bottomAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),

            platformView.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            platformView.centerYAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -22),
            platformView.widthAnchor.constraint(equalToConstant: 260),
            platformView.heightAnchor.constraint(equalToConstant: 42),

            goalStreakView.topAnchor.constraint(equalTo: toggleControl.bottomAnchor, constant: 40),
            goalStreakView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            goalStreakView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),

            statsContainer.topAnchor.constraint(equalTo: toggleControl.bottomAnchor),
            statsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            lockerSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lockerSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lockerSection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            lockerSection.heightAnchor.constraint(equalToConstant: 150)
        ])

        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.contentMode = .scaleAspectFit
    }
    
    private func setupStatsGrid() {
        statRingViews.removeAll()
        let stats = [
            (icon: "figure.strengthtraining.traditional", lvl: 1, p: 0.3),
            (icon: "figure.run", lvl: 2, p: 0.8),
            (icon: "heart.fill", lvl: 2, p: 0.6),
            (icon: "figure.step.training", lvl: 2, p: 0.9),
            (icon: "figure.strengthtraining.functional", lvl: 1, p: 0.4),
            (icon: "target", lvl: 2, p: 0.7)
        ]
        
        statsContainer.subviews.forEach { $0.removeFromSuperview() }

        for (index, stat) in stats.enumerated() {
            let statView = CircularStatView(icon: stat.icon, level: stat.lvl, progress: stat.p)
            statsContainer.addSubview(statView)
            statRingViews.append(statView)
            statView.translatesAutoresizingMaskIntoConstraints = false
            
            let isLeft = index < 3
            
            let xOffset: CGFloat = isLeft ? -135 : 135
            let yOffsets: [CGFloat] = [-110, -20, 70]
            
            NSLayoutConstraint.activate([
                statView.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor, constant: xOffset),
                statView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: yOffsets[index % 3]),
                statView.widthAnchor.constraint(equalToConstant: 70),
                statView.heightAnchor.constraint(equalToConstant: 70)
            ])
        }
    }
    
    private func setupToggleLogic() {
        goalStreakView.isHidden = true
        statsContainer.isHidden = false
        
        toggleControl.onToggle = { [weak self] index in
            guard let self = self else { return }
            let isStatsMode = (index == 0)
            
            if isStatsMode {
                self.statRingViews.forEach { $0.animateProgress() }
            }
            else {
                self.goalStreakView.animateCardsIn()
                self.goalStreakView.animateWeeklyGoalProgress()
            }
            
            UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve) {
                self.statsContainer.isHidden = !isStatsMode
                self.goalStreakView.isHidden = isStatsMode
                self.avatarImageView.transform = isStatsMode ? .identity : CGAffineTransform(translationX: -80, y: 0)
                self.platformView.transform = isStatsMode ? .identity : CGAffineTransform(translationX: -80, y: 0)
            }
        }
    }
    
    @objc private func didTapAvatar() {
        let editorVC = AvatarEditorViewController()
        editorVC.modalPresentationStyle = .fullScreen
        present(editorVC, animated: true)
    }
}
