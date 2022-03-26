//
//  AvailableShiftsData.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation

struct AvailableShiftsData: Decodable {
    let date: String
    let shifts: [Shift]
}
