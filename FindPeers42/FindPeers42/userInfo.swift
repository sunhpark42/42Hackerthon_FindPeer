//
//  userInfo.swift
//  FindPeers42
//
//  Created by Sunhee Park on 2020/12/16.
//

import Foundation

struct APIResponse: Codable {
    let results: [UserInfo]
}

struct UserInfo: Codable {
    let name : String
}
