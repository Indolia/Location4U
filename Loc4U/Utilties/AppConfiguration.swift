//
//  AppConfiguration.swift
//  Loc4U
//
//  Created by Rishi pal on 18/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation


//class is use for configuration the app setting to get local and save it and notify the sever change data, all other static/dynamic config also set as per app use cases
class AppConfiguration {
    
    enum LocationFetchMode: String {
        case forground = "Forgound"
        case backgound = "backgound"
        case killed   = "killed"
    }
   
    let LocationFetchTimeInterval: TimeInterval = 13
    
    
    
    
}
