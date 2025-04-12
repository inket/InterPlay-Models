import Foundation

public struct Source: Codable, Hashable, Sendable {
    enum CodingKeys: String, CodingKey {
        case name
        case baseURL = "base_url"
        case users
        case feeds
    }

    public let name: String
    public let baseURL: URL
    public let users: [User]
    public let feeds: [FeedDefinition]

    public init(name: String, baseURL: URL, users: [User], feeds: [FeedDefinition]) {
        self.name = name
        self.baseURL = baseURL
        self.users = users
        self.feeds = feeds
    }
}
