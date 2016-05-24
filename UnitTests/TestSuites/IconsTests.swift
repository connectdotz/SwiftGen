//
//  IconsTests.swift
//  SwiftGen
//
//  Created by Ignacio Romero on 5/23/16.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import XCTest
import GenumKit
import PathKit

class IconsJSONFileTests: XCTestCase {
    
    func testFileWithDefaults() {
        let parser = IconsJSONFileParser()
        do {
            try parser.parseFile(fixturePath("icons.json"))
        } catch {
            XCTFail("Exception while parsing file: \(error)")
        }
        
        let template = GenumTemplate(templateString: fixtureString("icons-default.stencil"))
        let result = try! template.render(parser.stencilContext())
        
        let expected = self.fixtureString("Icons-File-Default.swift.out")
        XCTDiffStrings(result, expected)
    }
}
