//
//  AvailableShiftsJSON.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 27/03/2022.
//

import Foundation

struct AvailableShiftsJSON {
    static var sample: String {
        load(fileName: "AvailableShiftsResponse")
    }
    
    private static func load(fileName: String) -> String {
        let bundle = Bundle(for: AvailableShiftsViewModel.self)
        
        guard
            let filepath = bundle.path(forResource: fileName, ofType: "json"),
            let contents = try? String(contentsOfFile: filepath) else {
                fatalError("Could not load contents of '\(fileName)'.json")
            }
        return contents
    }
}
