//
//  AvailableShifts+sample.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 27/03/2022.
//

import Foundation

extension AvailableShifts {
    static var sample: AvailableShifts {
        deserialize(json: AvailableShiftsJSON.sample)
    }
    
    private static func deserialize(json: String) -> AvailableShifts {
        guard
            let rawData = json.data(using: .utf8),
            let deserialized = try? JSONDecoder.shiftsDecoder.decode(AvailableShifts.self, from: rawData) else {
                fatalError("Could not deserialize \(self)")
            }
        return deserialized
    }
}
