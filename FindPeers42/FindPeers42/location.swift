// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let project = try? newJSONDecoder().decode(Project.self, from: jsonData)

import Foundation

// MARK: - Project
struct Location: Codable {
    let id: Int
    let host: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case host
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let login: String
    let url: String
}
