//
//  AvailableShifts.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation

struct AvailableShifts: Decodable {
    let data: [AvailableShiftsData]
    let meta: AvailableShiftsMeta
}
