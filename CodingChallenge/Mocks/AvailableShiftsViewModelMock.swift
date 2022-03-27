//
//  AvailableShiftsViewModelSample.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 27/03/2022.
//

import Foundation

final class AvailableShiftsViewModelMock: ObservableObject, AvailableShiftsViewModelProtocol {
    @Published var availableShiftsData: [AvailableShiftsData]
    
    init(availableShifts: AvailableShifts) {
        self.availableShiftsData = availableShifts.data
    }
    
    func firstDataFetch() {}
    func fetchMoreData() {}
    func displayedSectionWithDate(date: String) {}
}
