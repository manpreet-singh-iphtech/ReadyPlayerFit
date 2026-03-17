//
//  MainTabBarViewController.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 28/01/26.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lobbyVC = LobbyViewController()
        lobbyVC.tabBarItem = UITabBarItem(title: "LOBBY", image: UIImage(systemName: "dpad.fill"), tag: 0)
        
        let workoutVC = WorkoutViewController()
        workoutVC.tabBarItem = UITabBarItem(title: "WORKOUT", image: UIImage(systemName: "dumbbell.fill"), tag: 1)
        
        let historyVC = HistoryViewController()
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock.fill"), tag: 2)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person.fill"), tag: 3)
        
        viewControllers = [lobbyVC, workoutVC, historyVC, profileVC]
        selectedIndex = 0
        
        tabBar.barTintColor = .bgDark
        tabBar.tintColor = .neonCyan
        tabBar.unselectedItemTintColor = .textGray
        tabBar.isTranslucent = false
        self.setupAppearance()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let newHeight: CGFloat = 80
        
        var tabFrame = tabBar.frame
        tabFrame.size.height = newHeight
        tabFrame.origin.y = view.frame.size.height - newHeight
        
        tabBar.frame = tabFrame
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .bgDark
        
        appearance.shadowColor = UIColor.white.withAlphaComponent(0.8)

        let itemAppearance = appearance.stackedLayoutAppearance
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        itemAppearance.selected.iconColor = .neonCyan
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.neonCyan]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
