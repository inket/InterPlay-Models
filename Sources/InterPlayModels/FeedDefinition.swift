import Foundation

public struct FeedDefinition: Codable, Hashable, Sendable {
    public let id: String
    public let name: String
    public let searchable: Bool

    public init(id: String, name: String, searchable: Bool) {
        self.id = id
        self.name = name
        self.searchable = searchable
    }
}
