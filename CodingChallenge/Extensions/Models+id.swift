//
//  Models+id.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 27/03/2022.
//

import Foundation

extension AvailableShiftsData: Identifiable {
    var id: String { date }
}

extension Shift: Identifiable {
    var id: Int { shiftId }
}
