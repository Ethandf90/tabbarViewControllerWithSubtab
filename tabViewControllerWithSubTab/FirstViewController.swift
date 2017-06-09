//
//  FirstViewController.swift
//  tabViewControllerWithSubTab
//
//  Created by Fei Dong on 2017-06-09.
//  Copyright © 2017 Ethan Dong. All rights reserved.
//

import UIKit

enum subTabType {
    case TAB1
    case TAB2
    
    static let allValues = [TAB1, TAB2]
}

let themeColorArray: [UIColor] = [UIColor.brown, UIColor.red]

class FirstViewController: UIViewController {
    
    // titles of the subtabs
    lazy var subTabArray: [String] = {
        return subTabType.allValues.map{ "\($0)" } as [String]
    }()
    
    // number of subtabs is decided by the number of subTabType cases
    lazy var tabSubView: subTabView = { [unowned self] in
        let frame = Utility.frameFromPercentage(x: 0, y: 0, width: 1, height: 0.08)
        // todo
        let view = subTabView(frame: frame, titleArray: self.subTabArray)
        view.delegate = self
        return view
        }()
    
    // controllers for pageViewController
    lazy var controllers: [UIViewController] = {
        var cons: [UIViewController] = [UIViewController]()
        for type in subTabType.allValues {
            let vc = self.homeSubVCFrom(type)
            cons.append(vc)
        }
        return cons
    }()
    
    // pageViewController.view will be added to self.view
    lazy var pageViewController: PageViewController = { [unowned self] in
        let pageVC = PageViewController(superController: self, controllers: self.controllers)
        pageVC.theDelegate = self
        let frame = Utility.frameFromPercentage(x: 0, y: 0.08, width: 1, height: 0.92)
        pageVC.view.frame = frame
        
        return pageVC
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // make sure (0, 0) of frame starts from the left bottom of navigation bar 
        navigationController?.navigationBar.isTranslucent = false

        self.title = "First"
        self.navigationController?.navigationBar.barTintColor = themeColorArray.first
        self.view.addSubview(tabSubView)
        self.view.addSubview(pageViewController.view)
    }

    

}

// MARK: helper
extension FirstViewController {
    
    //generate VC from tab enum
    func homeSubVCFrom(_ subType: subTabType) -> UIViewController {
        var controller: UIViewController!
        switch subType {
        case .TAB1:
            controller = Page1ViewController()
        case .TAB2:
            controller = Page2ViewController()
        }
        return controller
    }
}

extension FirstViewController: subTabViewDelegate {
    func subTabDidClicked(_ atIndex: NSInteger) {
        // change page; change UI theme
        pageViewController.setCurrentSubControllerWith(index: atIndex)
        self.navigationController?.navigationBar.barTintColor = themeColorArray[atIndex]
    }
}

extension FirstViewController: PageViewControllerDelegate {
    func pageCurrentSubControllerIndex(index: NSInteger, pageViewController: PageViewController) {
        //change subTab; change UI theme
        tabSubView.jumptoShow(at: index)
        self.navigationController?.navigationBar.barTintColor = themeColorArray[index]
    }
}
