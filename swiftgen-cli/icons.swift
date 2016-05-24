//
// SwiftGen
// Created by Ignacio Romero on 5/23/16.
// Copyright (c) 2015 Olivier Halligon
// MIT Licence
//

import Commander
import PathKit
import GenumKit
import Stencil

let iconsCommand = command(
    outputOption,
    templateOption("icons"), templatePathOption,
    Option<String>("enumName", "Icon", flag: "e", description: "The name of the enum to generate"),
    Argument<Path>("FILE", description: "Icons.json file to parse.", validator: fileExists)
) { output, templateName, templatePath, enumName, path in
    
    let filePath = String(path)
    
    let parser: IconsFileParser
    switch path.`extension` {
    case "json"?:
        let textParser = IconsJSONFileParser()
        try textParser.parseFile(filePath)
        parser = textParser
    default:
        throw ArgumentError.InvalidType(value: filePath, type: "JSON file", argument: nil)
    }
    
    do {
        let templateRealPath = try findTemplate("icons", templateShortName: templateName, templateFullPath: templatePath)
        let template = try GenumTemplate(path: templateRealPath)
        let context = parser.stencilContext(enumName: enumName)
        let rendered = try template.render(context)
        output.write(rendered, onlyIfChanged: true)
    } catch {
        print("Failed to render template \(error)")
    }
}
