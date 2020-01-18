//
//  Indexer.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
import UIKit

struct Indexer {
    
    static let shared = Indexer()
    
    enum RootViewType {
        case welcome
        case home
    }
    
  private  func getRootViewType()-> RootViewType {
        let userData = IKeyChain.load(key: AppConstants.UserInfo.key)
        if userData != nil {
            return .home
        }
        return .welcome
        
    }
    //MARK: - uncommit this code to show signin/signup option
//    func getRootViewType()-> RootViewType {
//        return .welcome
//    }
    
    func setRootView(for window: UIWindow) {
        let navViewController = UIViewController.get(with: "NavigationViewController", storyboard: AppConstants.Storyboard.main)
        var viewController: UIViewController?
        let rootViewType = getRootViewType()
        switch rootViewType {
        case .home:
            viewController = HomeViewController.get(with: AppConstants.ViewControllerStotyboardId.homeViewController, storyboard: AppConstants.Storyboard.main)
            break
        case .welcome:
            viewController = WelcomeViewController.get(with: AppConstants.ViewControllerStotyboardId.welcomeViewController, storyboard: AppConstants.Storyboard.main)
        }
        
        guard let someNavCV = navViewController as? UINavigationController else {
            fatalError("NavigationViewController not find, check it")
        }
        guard let someInitialVC = viewController else {
            fatalError("ViewController not find, check it")
        }
        
        someNavCV.viewControllers = [someInitialVC]
        window.rootViewController = someNavCV
        
    }
    
    func setWelcomeAsRoot() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let navViewController = UIViewController.get(with: "NavigationViewController", storyboard: AppConstants.Storyboard.main)
        var viewController: UIViewController?
      
        viewController = WelcomeViewController.get(with: AppConstants.ViewControllerStotyboardId.welcomeViewController, storyboard: AppConstants.Storyboard.main)
        
        guard let someNavCV = navViewController as? UINavigationController else {
            fatalError("NavigationViewController not find, check it")
        }
        guard let someInitialVC = viewController else {
            fatalError("ViewController not find, check it")
        }
        
        someNavCV.viewControllers = [someInitialVC]
        appDelegate.window?.rootViewController = someNavCV
    }
    
}
