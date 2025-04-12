import Foundation

public struct Feed: Codable, Hashable, Sendable {
    public let definition: FeedDefinition
    public let videos: [Video]

    public init(definition: FeedDefinition, videos: [Video]) {
        self.definition = definition
        self.videos = videos
    }
}
