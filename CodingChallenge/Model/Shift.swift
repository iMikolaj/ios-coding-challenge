//
//  Shift.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation

struct Shift: Decodable {
    let shiftId: Int
    let startTime, endTime: Date
    let normalizedStartDateTime: String
    let normalizedEndDateTime: String
    let timezone: String
    let premiumRate: Bool
    let covid: Bool
    let shiftKind: String
    let withinDistance: Int
    let facilityType: FacilityType
    let skill: Skill
    let localizedSpecialty: LocalizedSpecialty
}
