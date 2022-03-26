//
//  JSONDecoder+availableShiftsDecoder.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation

extension JSONDecoder {
     static var shiftsDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
