// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let id, occurrence, finalMark: Int
    let status: String
    let validated: Bool
    let currentTeamID: Int
    let project: Project
    let cursusIDS: [Int]
    let markedAt: String
    let marked: Bool
    let retriableAt: String
    let user: WelcomeUser
    let teams: [Team]

    enum CodingKeys: String, CodingKey {
        case id, occurrence
        case finalMark = "final_mark"
        case status
        case validated = "validated?"
        case currentTeamID = "current_team_id"
        case project
        case cursusIDS = "cursus_ids"
        case markedAt = "marked_at"
        case marked
        case retriableAt = "retriable_at"
        case user, teams
    }
}

// MARK: - Project
struct Project: Codable {
    let id: Int
    let name, slug: String
    let parentID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case parentID = "parent_id"
    }
}

// MARK: - Team
struct Team: Codable {
    let id: Int
    let name: String
    let url: String
    let finalMark: Int?
    let projectID: Int
    let createdAt, updatedAt, status: String
    let terminatingAt: JSONNull?
    let users: [UserElement]
    let locked: Bool
    let validated: Bool?
    let closed: Bool
    let repoURL, repoUUID, lockedAt, closedAt: String
    let projectSessionID: Int
    let projectGitlabPath: String

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case finalMark = "final_mark"
        case projectID = "project_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case status
        case terminatingAt = "terminating_at"
        case users
        case locked = "locked?"
        case validated = "validated?"
        case closed = "closed?"
        case repoURL = "repo_url"
        case repoUUID = "repo_uuid"
        case lockedAt = "locked_at"
        case closedAt = "closed_at"
        case projectSessionID = "project_session_id"
        case projectGitlabPath = "project_gitlab_path"
    }
}

// MARK: - UserElement
struct UserElement: Codable {
    let id: Int
    let login: String
    let url: String
    let leader: Bool
    let occurrence: Int
    let validated: Bool
    let projectsUserID: Int

    enum CodingKeys: String, CodingKey {
        case id, login, url, leader, occurrence, validated
        case projectsUserID = "projects_user_id"
    }
}

// MARK: - WelcomeUser
struct WelcomeUser: Codable {
    let id: Int
    let login: String
    let url: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
