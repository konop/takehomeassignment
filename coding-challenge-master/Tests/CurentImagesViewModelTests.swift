//
//  CurentImagesViewModelTests.swift
//  CodeChallengeTests
//
//  Created by Mark Pettersson on 2020-02-28.
//  Copyright © 2020 Hootsuite. All rights reserved.
//
//


import XCTest
@testable import CodeChallenge

class CurrentImagesViewModelTests: XCTestCase {

    func testPickTag() {
         let path = Bundle(for: type(of: self)).path(forResource: "ImageSetData", ofType: "json")!
                let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
                let imageSet: ImageSet = try! JSONDecoder().decode(ImageSet.self, from: jsonData)
                let myImagesViewModel = CurrentImagesViewModel()
                myImagesViewModel.myImageSet = imageSet
                myImagesViewModel.currentTag = "Dog"
                for _ in (0...100) {
                    myImagesViewModel.pickTag()
                    let newTag = myImagesViewModel.currentTag
                    XCTAssert(newTag != "Dog")
                }
            }
}

