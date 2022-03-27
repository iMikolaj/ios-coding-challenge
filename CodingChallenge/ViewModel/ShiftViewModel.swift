//
//  ShiftViewModel.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 27/03/2022.
//

import Foundation

protocol ShiftViewModelProtocol {
    var id: Int { get }
    var shift: Shift { get }
    var timeRange: String { get }
}

final class ShiftViewModel: ShiftViewModelProtocol, Identifiable {
    var id: Int { shift.id }
    let shift: Shift
    var timeRange: String {
        "\(shift.startTime.hourMin) - \(shift.endTime.hourMin)"
    }
    
    init(shift: Shift) {
        self.shift = shift
    }
}
