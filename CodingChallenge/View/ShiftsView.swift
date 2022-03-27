//
//  ShiftsView.swift
//  CodingChallenge
//
//  Created by Brady Miller on 4/7/21.
//

import SwiftUI
import Combine

struct ShiftsView<VM>: View where VM: AvailableShiftsViewModelProtocol {
    @StateObject var viewModel: VM
        
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.availableShiftsData) { availableShiftsData in
                    Section {
                        ForEach(availableShiftsData.shifts) { shift in
                            ShiftCellView(viewModel: ShiftViewModel(shift: shift))
                        }
                    } header: {
                        Text(availableShiftsData.date)
                    }
                    .onAppear {
                        viewModel.displayedSectionWithDate(date: availableShiftsData.date)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Shifts")
        }
        .onAppear {
            viewModel.firstDataFetch()
        }
    }
}


struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsView(viewModel: AvailableShiftsViewModelMock(availableShifts: AvailableShifts.sample))
    }
}
