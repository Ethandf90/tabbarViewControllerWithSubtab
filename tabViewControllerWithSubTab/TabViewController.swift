//
//  tabViewController.swift
//  tabViewControllerWithSubTab
//
//  Created by Fei Dong on 2017-06-09.
//  Copyright © 2017 Ethan Dong. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }

    private func setupViewController() {
        
        // ---------- to use your own ----------------------
        let first = FirstViewController()
        let second = SecondViewController()
        
        let viewControllerArray = [first, second]
        let titleArray = ["First", "Second"]
        let normalImagesArray = [Asset.first.image, Asset.second.image]
        let selectedImagesArray = [Asset.first.image, Asset.second.image]
        // -------------------------------------------------

        //make sure above arraies same length
        assert(viewControllerArray.count == titleArray.count, "TabbarViewController - array ont same size")
        assert(normalImagesArray.count == selectedImagesArray.count, "TabbarViewController - array ont same size")
        
        let navigationVCArray = NSMutableArray()
        for (index, controller) in viewControllerArray.enumerated() {
            controller.tabBarItem!.title = titleArray[index]
            controller.tabBarItem!.image = normalImagesArray[index].withRenderingMode(.alwaysOriginal)
            controller.tabBarItem!.selectedImage = selectedImagesArray[index].withRenderingMode(.alwaysOriginal)
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: UIControlState())
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .selected)
            
            let navigationController = UINavigationController(rootViewController: controller)
            navigationVCArray.add(navigationController)
        }
        
        self.viewControllers = navigationVCArray.mutableCopy() as! [UINavigationController]
        
    }


}
