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
        setupTabBar()
        setupViewControllers()
        setupTabBarAppearance()
        selectedIndex = 0
    }
    
    private func setupTabBar() {
        let TabBar = TabBar()
        setValue(TabBar, forKey: "tabBar")
    }
        
    private func setupViewControllers() {
        let feedViewController = FeedViewController()
        let heartViewController = HeartViewController()
        let CameraViewController = CameraViewController()
        let SearchViewController = SearchViewController()
        let SettingViewController = SettingViewController()
        
        let feedTab = UINavigationController(rootViewController: feedViewController)
        let heartTab = UINavigationController(rootViewController: heartViewController)
        let CameraTab = UINavigationController(rootViewController: CameraViewController)
        let SearchTab = UINavigationController(rootViewController: SearchViewController)
        let SettingTab = UINavigationController(rootViewController: SettingViewController)
        
        // 메인 탭
        feedViewController.tabBarItem = UITabBarItem(
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
            image: UIImage(systemName: "circle.square"),
            selectedImage: UIImage(systemName: "circle.square.fill")
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
        
        self.viewControllers = [feedTab, heartTab, CameraTab, SearchTab, SettingTab]
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        // 선택되지 않은 상태 스타일
        appearance.stackedLayoutAppearance.normal.iconColor = .darkGray
        
        // 선택된 상태 스타일
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        
        // SE 모델일 경우 타이틀 위치 조정
        if UIScreen.isiPhoneSE {
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
            appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        }
        
        // SE 모델일 경우 아이콘 위치 조정
        if UIScreen.isiPhoneSE {
            for item in tabBar.items ?? [] {
                item.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
            }
        }
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance  // 배경이 사라지지 않도록 설정함
    }
}
