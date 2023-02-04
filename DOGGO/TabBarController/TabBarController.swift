//
//  TabBarControlle.swift
//  DOGGO
//
//  Created by Lobster on 13.01.23.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        SetTabBarAppearance()
        
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: TasksVC(),
                title: "Tasks",
                image: UIImage(systemName: "checkmark.circle.fill")
            ),
            generateVC(
                viewController: RemindersVC(),
                title: "Reminders",
                image: UIImage(systemName: "list.clipboard.fill")
            ),
            generateVC(
                viewController: DogsVC(),
                title: "Dogs",
                image: UIImage(systemName: "pawprint.fill")
            ),
            generateVC(
                viewController: ProfileVC(),
                title: "Person",
                image: UIImage(systemName: "person.fill")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    private func SetTabBarAppearance() {
        
        
        let positionX: CGFloat = 15.0
        let positionY: CGFloat = 15.0
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        let minY = tabBar.bounds.minY
        
        
        let roundLayer = CAShapeLayer()
        
        
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionX,
                y: minY - positionY,
                width: width,
                height: height
            ),
            cornerRadius: height / 3.1
        )
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
//        tabBar.itemWidth = width
//        tabBar.itemPositioning = .centered
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        
        roundLayer.fillColor = UIColor.tabBarColor.cgColor
        tabBar.tintColor = .selectedItem
        tabBar.unselectedItemTintColor = .unselectedItem
    }
    
    
    
    
    
}

