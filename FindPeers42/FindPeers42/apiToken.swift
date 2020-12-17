//
//  apiToken.swift
//  FindPeers42
//
//  Created by Sunhee Park on 2020/12/17.
//

import Foundation

struct Token: Codable {
    var access_token: String
    var token_type: String
    var expires_in: String
    var scope: String
    var created_at: String
}
