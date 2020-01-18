//
//  AppConstants.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
//Use for define the contants for app
struct AppConstants {
    struct UserInfo {
        static let key:String = "location_for_you_user_info_key"
    }
    struct  Storyboard {
       static let main = "Main"
    }
    struct ViewControllerStotyboardId {
        static let navigationViewController = "NavigationViewController"
        static let welcomeViewController = "WelcomeViewController"
        static let signInOrSignUpViewController  = "SignInOrSignUpViewController"
        static let homeViewController = "HomeViewController"
    }
    
    struct ServerURL {
        
        //set your base url
        static let baseUrl = "https://"
    }
}
