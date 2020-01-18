//
//  NetworkManager.swift
//  Loc4U
//
//  Created by Rishi pal on 19/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
import Reachability

protocol NetworkManagerDelegate: class {
    func didNetowrkUnreachable()
    func didNetowrkReachable()
}

class NetworkManager {
    var reachability: Reachability?
    static let shared = NetworkManager()
    weak var delegate: NetworkManagerDelegate?
    private  init() {
        do {
            reachability = try Reachability()
            reachability?.whenReachable = {[weak self] reachability in
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                self?.delegate?.didNetowrkReachable()
            }
            reachability?.whenUnreachable = {[weak self]  _ in
                print("Not reachable")
                self?.delegate?.didNetowrkUnreachable()
            }
            try reachability?.startNotifier()
        } catch let error  {
            print("error is Reachability \(error.localizedDescription) ")
        }
    }
}
