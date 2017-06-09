//
//  PageViewController.swift
//  tabViewControllerWithSubTab
//
//  Created by Fei Dong on 2017-06-09.
//  Copyright © 2017 Ethan Dong. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: NSObjectProtocol {
    //notify the change of child view to outside
    func pageCurrentSubControllerIndex(index: NSInteger, pageViewController: PageViewController)
}

class PageViewController: UIPageViewController {

    weak var theDelegate: PageViewControllerDelegate?
    
    fileprivate var superController: UIViewController!
    fileprivate var childControllers: [UIViewController] = [UIViewController]()
    
    init(superController: UIViewController, controllers: [UIViewController]) {
        let options: [String : Any] = [UIPageViewControllerOptionSpineLocationKey : NSNumber(integerLiteral: UIPageViewControllerSpineLocation.none.rawValue)]
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        
        self.superController = superController
        self.childControllers = controllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIPageViewController has an underlying cache, reset it
        self.dataSource = nil
        self.dataSource = self
        self.delegate = nil
        self.delegate = self
        
        setup()
    }
    
    // MARK: setup
    fileprivate func setup() {
        if childControllers.count == 0 { return }
        //set viewControllers for UIPageViewController
        self.setViewControllers([childControllers.first!], direction: .forward, animated: false, completion: nil)
        
    }
    
    // MARK: public methods
    // change child view from outside
    func setCurrentSubControllerWith(index: NSInteger) {
        setViewControllers([childControllers[index]], direction: .forward, animated: false, completion: nil)
    }
    
    
}

// MARK: UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // previous controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = childControllers.index(of: viewController) else { return nil }
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        return childControllers[index - 1]
    }
    
    /// next controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = self.childControllers.index(of: viewController) else { return nil }
        
        if index == NSNotFound || index == childControllers.count - 1 {
            return nil
        }
        return childControllers[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return childControllers.count
    }
    
    // when jumping to another vc
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let vc = pageViewController.viewControllers?[0] else { return }
        
        if let index = childControllers.index(of: vc) {
            theDelegate?.pageCurrentSubControllerIndex(index: index, pageViewController: self)
        }
        
    }
}

