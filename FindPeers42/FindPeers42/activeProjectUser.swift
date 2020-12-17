//
//  activeProjectUser.swift
//  FindPeers42
//
//  Created by Sunhee Park on 2020/12/18.
//

import Foundation

struct ActiveProjectUser {
    var name: String
    var location: String
    var status: String // "all_bonus", "finished", "in_progress"
    
    enum CodingKeys: String, CodingKey {
        case name, location, status
    }
}
