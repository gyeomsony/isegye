//
//  TabBarController.swift
//  isegye
//
//  Created by 손겸 on 2/25/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("뷰디드로드 실행됨")
        setupViewControllers()
        selectedIndex = 0
    }
        
    private func setupViewControllers() {
        let mainViewController = MainViewController()
        let heartViewController = HeartViewController()
        let CameraViewController = CameraViewController()
        let SearchViewController = SearchViewController()
        let SettingViewController = SettingViewController()
        
        let mainTab = UINavigationController(rootViewController: mainViewController)
        let heartTab = UINavigationController(rootViewController: heartViewController)
        let CameraTab = UINavigationController(rootViewController: CameraViewController)
        let SearchTab = UINavigationController(rootViewController: SearchViewController)
        let SettingTab = UINavigationController(rootViewController: SettingViewController)
        
        // 메인 탭
        mainViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        // 좋아요 탭
        heartViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        // 카메라 탭
        CameraViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "camera"),
            selectedImage: UIImage(systemName: "camera.fill")
        )
        
        // 검색 탭
        SearchViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        
        SettingViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .darkGray
        
        self.viewControllers = [mainTab, heartTab, CameraTab, SearchTab, SettingTab]
    }
}
