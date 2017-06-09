//
//  subTabView.swift
//  tabViewControllerWithSubTab
//
//  Created by Fei Dong on 2017-06-09.
//  Copyright © 2017 Ethan Dong. All rights reserved.
//

import UIKit

protocol subTabViewDelegate: NSObjectProtocol {
    func subTabDidClicked(_ atIndex: NSInteger)
}

class subTabView: UIView {

    weak var delegate: subTabViewDelegate?
    
    var buttonArray: [UIButton] = [UIButton]()
    var currentButton: UIButton!
    
    //get set on init; the array count determines the number of buttons
    var titleArray: [String] = []
    
    // the lineView taht will slide when clicking on tabs
    lazy var bottomLineView: UIView = {
        // the whole height of subtabView is 0.08
        let width: CGFloat = CGFloat(1) / CGFloat(self.titleArray.count)
        let frame = Utility.frameFromPercentage(x: 0, y: 0.08 - 0.01, width: width, height: 0.008)
        let view = UIView(frame: frame)
        //todo
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    convenience init(frame: CGRect, titleArray: [String]) {
        self.init(frame: frame)
        
        self.titleArray = titleArray
        configsubTabs()
    }

    // button action
    func subTabClick(_ button: UIButton) {
        
        if button == currentButton {
            return
        }
        
        delegate?.subTabDidClicked(buttonArray.index(of: button)!)
        
        selectedAtBtn(button)
    }
    
    // jump to another button
    public func jumptoShow(at index: NSInteger) {
        if index < 0 || index >= buttonArray.count {
            return
        }
        let btn = buttonArray[index]
        selectedAtBtn(btn)
    }
    
}

// MARK: set up tab
extension subTabView {
    
    fileprivate func configsubTabs() {
        assert(titleArray.count == themeColorArray.count, "HZHomeSubTabView - more than two subTab, need more color setting")
        
        let btnWidth: CGFloat = CGFloat(1) / CGFloat(self.titleArray.count)
        
        //add buttons as subtab
        for i in 0 ..< titleArray.count {
            let frame = Utility.frameFromPercentage(x: 0 + btnWidth * CGFloat(i), y: 0, width: btnWidth, height: 0.08)
            let button = UIButton(type: .custom)
            button.frame = frame
            let title = titleArray[i]
            
            // todo
            //            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            
            button.addTarget(self, action: #selector(subTabClick(_ :)), for: .touchUpInside)
            buttonArray.append(button)
            addSubview(button)
            
        }
        
        //set view background color, instead of button color, since button colors will be the same, in one color theme
        backgroundColor = themeColorArray.first
        
        addSubview(bottomLineView)
        
        //select first tab on start
        guard let firstButton = buttonArray.first else { return }
        selectedAtBtn(firstButton)
    }
    
    
    fileprivate func selectedAtBtn(_ button: UIButton) {
        button.isSelected = true
        currentButton = button
        
        let index = buttonArray.index(of: button)!
        let width: CGFloat = CGFloat(1) / CGFloat(self.titleArray.count)
        let frame = Utility.frameFromPercentage(x: 0 + width * CGFloat(index), y: 0.08 - 0.01, width: width, height: 0.01)
        //move bottomLineView
        UIView.animate(withDuration: 0.5) {
            self.bottomLineView.frame = frame
        }
        
        unselectOtherButton(button)
        changeUITheme(atIndex: index)
    }
    
    fileprivate func unselectOtherButton(_ button: UIButton) {
        for btn in buttonArray {
            if button == btn {
                continue
            }
            btn.isSelected = false
        }
    }
    
    fileprivate func changeUITheme(atIndex: NSInteger) {
        backgroundColor = themeColorArray[atIndex]
    }
    
}

