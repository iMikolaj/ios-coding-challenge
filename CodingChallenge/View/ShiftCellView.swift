//
//  ShiftCellView.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 27/03/2022.
//

import SwiftUI
import Combine


struct ShiftCellView: View {
    var viewModel: ShiftViewModelProtocol
    @State private var presentingDetails = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(viewModel.shift.facilityType.name)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
                Text(viewModel.timeRange)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            
            HStack {
                Text(viewModel.shift.localizedSpecialty.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(viewModel.shift.withinDistance) mil")
                    .font(.footnote)
            }
        }
        .onTapGesture {
            presentingDetails = true
        }
        .sheet(isPresented: $presentingDetails, onDismiss: {
            presentingDetails = false
        }, content: {
            ShiftDetailsView(viewModel: viewModel)
        })
    }
}

struct ShiftCellView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftCellView(
            viewModel: ShiftViewModel(
                shift: AvailableShifts.sample.data[0].shifts[0]
            )
        )
    }
}
