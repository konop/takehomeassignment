//  Copyright © 2018 Hootsuite. All rights reserved.

import XCTest
@testable import CodeChallenge

class InterviewAPITests: XCTestCase {

    func testURLRequest() {
        let urlComponents = URLComponents(url: APIRequests.request.url, resolvingAgainstBaseURL: false)
        XCTAssertEqual(urlComponents?.scheme, "https")
        XCTAssertEqual(urlComponents?.path, "/steve-sun-hs/8234979f673e62b28c47a8b57b5dc2f2/raw/b71bd881ecc5097cf41ab7dcbcbb875eec7bfda4/Questions.json")
    }
}
