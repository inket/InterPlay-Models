import Foundation

public struct Video: Codable, Hashable, Sendable {
    public enum Availability: Codable, Hashable, Sendable {
        enum CodingKeys: String, CodingKey, Codable, Sendable {
            case status
            case unavailable
            case downloading
            case available
        }

        enum Properties: String, CodingKey, Codable, Sendable {
            case progress
            case playbackURL = "playback_url"
        }

        case unavailable
        case downloading(_ progress: Double)
        case available(_ playbackURL: URL)

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: Video.Availability.CodingKeys.self)
            let decodingType: CodingKeys = try container.decode(Video.Availability.CodingKeys.self, forKey: .status)

            switch decodingType {
            case .status:
                throw DecodingError.typeMismatch(
                    Video.Availability.CodingKeys.self,
                    DecodingError.Context.init(
                        codingPath: container.codingPath,
                        debugDescription: "Availability status cannot be 'status'",
                        underlyingError: nil
                    )
                )
            case .unavailable:
                self = .unavailable
            case .downloading:
                let progress = try decoder
                    .container(keyedBy: Video.Availability.Properties.self)
                    .decode(Double.self, forKey: .progress)
                self = .downloading(progress)
            case .available:
                let playbackURL = try decoder
                    .container(keyedBy: Video.Availability.Properties.self)
                    .decode(URL.self, forKey: .playbackURL)
                self = .available(playbackURL)
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: Video.Availability.CodingKeys.self)

            switch self {
            case .unavailable:
                try container.encode(CodingKeys.unavailable, forKey: .status)
            case .downloading(let progress):
                try container.encode(CodingKeys.downloading, forKey: .status)
                var propertiesContainer = encoder.container(keyedBy: Video.Availability.Properties.self)
                try propertiesContainer.encode(progress, forKey: .progress)
            case .available(let playbackURL):
                try container.encode(CodingKeys.available, forKey: .status)
                var propertiesContainer = encoder.container(keyedBy: Video.Availability.Properties.self)
                try propertiesContainer.encode(playbackURL, forKey: .playbackURL)
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnailURL = "thumbnail_url"
        case subtitle
        case collection
        case publishedTimestamp = "published_timestamp"
        case availability
        case duration
    }

    public let title: String
    public let thumbnailURL: URL

    public let subtitle: String?
    public let collection: Collection?

    public let publishedTimestamp: TimeInterval?

    public var publishedDate: Date? {
        publishedTimestamp.flatMap { Date(timeIntervalSince1970: $0) }
    }

    public let availability: Availability
    public let duration: TimeInterval?

    public init(
        title: String,
        thumbnailURL: URL,
        subtitle: String?,
        collection: Collection?,
        publishedTimestamp: TimeInterval?,
        availability: Availability,
        duration: TimeInterval?
    ) {
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.subtitle = subtitle
        self.collection = collection
        self.publishedTimestamp = publishedTimestamp
        self.availability = availability
        self.duration = duration
    }
}
