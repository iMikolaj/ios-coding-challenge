//
//  AvailableShiftsViewModel.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 27/03/2022.
//

import Foundation
import Combine

protocol AvailableShiftsViewModelProtocol: ObservableObject {
    var availableShiftsData: [AvailableShiftsData] { get }
    func firstDataFetch()
    func fetchMoreData()
    func displayedSectionWithDate(date: String)
}

final class AvailableShiftsViewModel: ObservableObject, AvailableShiftsViewModelProtocol {
    private let networking: ShiftsNetworkingProtocol
    private var disposables = Set<AnyCancellable>()
    private var lastDates = [String]()
    private var duringFetchingData = false
    private var calendar = Calendar.current
    private var endDate: Date?
    
    @Published var availableShiftsData = [AvailableShiftsData]()
    
    init(networking: ShiftsNetworkingProtocol = ShiftsNetworking()) {
        self.networking = networking
    }
    
    private func fetchData(startDate: Date) {
        guard !duringFetchingData else { return }
        
        endDate = calendar.date(byAdding: .day, value: 7, to: startDate)
        
        let address = "Dallas, TX"
        let radius = 10
        
        duringFetchingData = true
        networking.fetchAvailableShifts(
            address: address,
            startDate: startDate,
            endDate: endDate,
            radius: radius,
            type: .list
        )
            .receive(on: DispatchQueue.main)
            .sink { _ in }
                receiveValue: { [weak self] availableShifts in
                    self?.lastDates = availableShifts.data.suffix(3).map{ $0.date }
                    self?.availableShiftsData.append(contentsOf: availableShifts.data)
                    self?.duringFetchingData = false
                }
            .store(in: &disposables)
    }
        
    func firstDataFetch() {
        fetchData(startDate: Date())
    }
    
    func fetchMoreData() {
        if let lastShiftDate = availableShiftsData.last?.shifts.last?.endTime, let endDate = endDate {
            fetchData(startDate: max(lastShiftDate, endDate))
        }
    }
    
    func displayedSectionWithDate(date: String) {
        if lastDates.contains(date) {
            fetchMoreData()
        }
    }
}
