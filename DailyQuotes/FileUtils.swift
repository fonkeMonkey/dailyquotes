//
//  FileUtils.swift
//  DailyQuotes
//
//  Created by Pavol Virdzek on 26/04/2020.
//  Copyright © 2020 Pavol Virdzek. All rights reserved.
//

import Foundation

func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
    guard let path = Bundle.main.path(forResource: fileName, ofType: nil) else {
        return nil
    }

    do {
        let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
        return content.components(separatedBy: "\n")
    } catch {
        return nil
    }
}
