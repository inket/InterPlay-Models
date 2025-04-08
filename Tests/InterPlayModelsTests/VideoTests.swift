import XCTest
@testable import InterPlayModels

final class VideoTests: XCTestCase {
    func testDecodingCompleteVideo() throws {
        let json = """
        {
            "title": "Test Video",
            "thumbnail_url": "https://example.com/thumbnail.jpg",
            "subtitle": "Test Subtitle",
            "collection": {
                "name": "Test Collection",
                "image_url": "https://example.com/collection.jpg"
            },
            "published_timestamp": 1710936000,
            "availability": {
                "status": "unavailable"
            }
        }
        """
        
        let data = json.data(using: .utf8)!
        let video = try JSONDecoder().decode(Video.self, from: data)
        
        XCTAssertEqual(video.title, "Test Video")
        XCTAssertEqual(video.thumbnailURL.absoluteString, "https://example.com/thumbnail.jpg")
        XCTAssertEqual(video.subtitle, "Test Subtitle")
        XCTAssertEqual(video.collection?.name, "Test Collection")
        XCTAssertEqual(video.collection?.imageURL?.absoluteString, "https://example.com/collection.jpg")
        XCTAssertEqual(video.publishedDate?.timeIntervalSince1970, 1710936000)
        XCTAssertEqual(video.availability, .unavailable)
    }
    
    func testDecodingVideoWithoutCollection() throws {
        let json = """
        {
            "title": "Test Video",
            "thumbnail_url": "https://example.com/thumbnail.jpg",
            "subtitle": "Test Subtitle",
            "published_timestamp": 1710936000,
            "availability": {
                "status": "unavailable"
            }
        }
        """
        
        let data = json.data(using: .utf8)!
        let video = try JSONDecoder().decode(Video.self, from: data)
        
        XCTAssertEqual(video.title, "Test Video")
        XCTAssertEqual(video.thumbnailURL.absoluteString, "https://example.com/thumbnail.jpg")
        XCTAssertEqual(video.subtitle, "Test Subtitle")
        XCTAssertNil(video.collection)
        XCTAssertEqual(video.publishedDate?.timeIntervalSince1970, 1710936000)
        XCTAssertEqual(video.availability, .unavailable)
    }
    
    func testDecodingVideoWithoutPublishedDate() throws {
        let json = """
        {
            "title": "Test Video",
            "thumbnail_url": "https://example.com/thumbnail.jpg",
            "subtitle": "Test Subtitle",
            "collection": {
                "name": "Test Collection",
                "image_url": "https://example.com/collection.jpg"
            },
            "availability": {
                "status": "unavailable"
            }
        }
        """
        
        let data = json.data(using: .utf8)!
        let video = try JSONDecoder().decode(Video.self, from: data)
        
        XCTAssertEqual(video.title, "Test Video")
        XCTAssertEqual(video.thumbnailURL.absoluteString, "https://example.com/thumbnail.jpg")
        XCTAssertEqual(video.subtitle, "Test Subtitle")
        XCTAssertEqual(video.collection?.name, "Test Collection")
        XCTAssertEqual(video.collection?.imageURL?.absoluteString, "https://example.com/collection.jpg")
        XCTAssertNil(video.publishedDate)
        XCTAssertEqual(video.availability, .unavailable)
    }
    
    func testDecodingVideoWithDownloadingAvailability() throws {
        let json = """
        {
            "title": "Test Video",
            "thumbnail_url": "https://example.com/thumbnail.jpg",
            "subtitle": "Test Subtitle",
            "collection": {
                "name": "Test Collection",
                "image_url": "https://example.com/collection.jpg"
            },
            "published_timestamp": 1710936000,
            "availability": {
                "status": "downloading",
                "progress": 0.5
            }
        }
        """
        
        let data = json.data(using: .utf8)!
        let video = try JSONDecoder().decode(Video.self, from: data)
        
        XCTAssertEqual(video.title, "Test Video")
        XCTAssertEqual(video.thumbnailURL.absoluteString, "https://example.com/thumbnail.jpg")
        XCTAssertEqual(video.subtitle, "Test Subtitle")
        XCTAssertEqual(video.collection?.name, "Test Collection")
        XCTAssertEqual(video.collection?.imageURL?.absoluteString, "https://example.com/collection.jpg")
        XCTAssertEqual(video.publishedDate?.timeIntervalSince1970, 1710936000)
        
        if case .downloading(let progress) = video.availability {
            XCTAssertEqual(progress, 0.5)
        } else {
            XCTFail("Expected downloading availability with progress 0.5")
        }
    }
    
    func testDecodingVideoWithAvailableAvailability() throws {
        let json = """
        {
            "title": "Test Video",
            "thumbnail_url": "https://example.com/thumbnail.jpg",
            "subtitle": "Test Subtitle",
            "collection": {
                "name": "Test Collection",
                "image_url": "https://example.com/collection.jpg"
            },
            "published_timestamp": 1710936000,
            "availability": {
                "status": "available",
                "playback_url": "https://example.com/video.mp4"
            }
        }
        """
        
        let data = json.data(using: .utf8)!
        let video = try JSONDecoder().decode(Video.self, from: data)
        
        XCTAssertEqual(video.title, "Test Video")
        XCTAssertEqual(video.thumbnailURL.absoluteString, "https://example.com/thumbnail.jpg")
        XCTAssertEqual(video.subtitle, "Test Subtitle")
        XCTAssertEqual(video.collection?.name, "Test Collection")
        XCTAssertEqual(video.collection?.imageURL?.absoluteString, "https://example.com/collection.jpg")
        XCTAssertEqual(video.publishedDate?.timeIntervalSince1970, 1710936000)
        
        if case .available(let url) = video.availability {
            XCTAssertEqual(url.absoluteString, "https://example.com/video.mp4")
        } else {
            XCTFail("Expected available availability with URL")
        }
    }
    
    func testDecodingVideoWithInvalidAvailability() throws {
        let json = """
        {
            "title": "Test Video",
            "thumbnail_url": "https://example.com/thumbnail.jpg",
            "subtitle": "Test Subtitle",
            "collection": {
                "name": "Test Collection",
                "image_url": "https://example.com/collection.jpg"
            },
            "published_date": 1710936000,
            "availability": "invalid"
        }
        """
        
        let data = json.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(Video.self, from: data))
    }
} 
