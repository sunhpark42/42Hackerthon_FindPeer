// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let project = try? newJSONDecoder().decode(Project.self, from: jsonData)

import Foundation

// MARK: - Project
struct Project: Codable {
    let id, occurrence, finalMark: Int?
    let status: String
    let project: ProjectClass
    let user: ProjectUser

    enum CodingKeys: String, CodingKey {
        case id, occurrence
        case finalMark = "final_mark"
        case status
        case project
        case user
    }
}

// MARK: - ProjectClass
struct ProjectClass: Codable {
    let id: Int
    let name, slug: String
    let parentID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case parentID = "parent_id"
    }
}

// MARK: - ProjectUser
struct ProjectUser: Codable {
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
