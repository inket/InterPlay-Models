import Foundation

public struct SourceQueryResult: Codable, Hashable, Sendable {
    public let title: String
    public let videos: [Video]

    public init(title: String, videos: [Video]) {
        self.title = title
        self.videos = videos
    }
}
