import Foundation

public struct User: Codable, Hashable, Sendable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
    }

    public let id: String
    public let name: String
    public let imageURL: URL?

    public init(id: String, name: String, imageURL: URL?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}
