import Foundation

public struct Collection: Codable, Hashable, Sendable {
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
    }

    public let name: String
    public let imageURL: URL?

    public init(name: String, imageURL: URL?) {
        self.name = name
        self.imageURL = imageURL
    }
}
