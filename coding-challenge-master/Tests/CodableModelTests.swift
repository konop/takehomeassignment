//  Copyright © 2018 Hootsuite. All rights reserved.

import XCTest
@testable import CodeChallenge

class CodableModelTests: XCTestCase {

    func testValidJSON() {
        let path = Bundle(for: type(of: self)).path(forResource: "ImageSetData", ofType: "json")!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
        let imageSet: ImageSet = try! JSONDecoder().decode(ImageSet.self, from: jsonData)

        XCTAssertEqual(imageSet.tags.count, 1)
        XCTAssertEqual(imageSet.tags.first!, "Bicycle")

        XCTAssertEqual(imageSet.sources.count, 2)
        let firstImage = imageSet.sources.first!
        XCTAssertEqual(firstImage.tags.first!, "BICYCLE")
        XCTAssertEqual(firstImage.tags.last!, "HOUSE")
        XCTAssertEqual(firstImage.url.absoluteString, "https://test123.com")

        let lastImage = imageSet.sources.last!
        XCTAssertEqual(lastImage.tags.first!, "DOG")
        XCTAssertEqual(lastImage.url.absoluteString, "https://test456.com")
    }

    func testInvalidJSON() {
        let path = Bundle(for: type(of: self)).path(forResource: "ImageSetInvalidData", ofType: "json")!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))

        do {
            let _ = try JSONDecoder().decode(ImageSet.self, from: jsonData)
            XCTFail("JSON should fail")
        } catch {

        }
    }
}
