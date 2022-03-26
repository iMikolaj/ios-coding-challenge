//
//  LocalizedSpecialty.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation

struct LocalizedSpecialty: Decodable {
    let id: Int
    let specialtyId: Int
    let stateId: Int
    let name: String
    let abbreviation: String
    let specialty: Specialty
}
