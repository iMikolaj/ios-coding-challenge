//
//  ShiftDetailsView.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 27/03/2022.
//

import SwiftUI

fileprivate struct Constants {
    static let horizontalSpacing: CGFloat = 4
    static let topPadding: CGFloat = 50
    static let horizonatalPadding: CGFloat = 16
}

struct ShiftDetailsView: View {
    @State var viewModel: ShiftViewModelProtocol
    
    var body: some View {
        VStack {
            ShiftDetailsHeaderView(viewModel: $viewModel)
            Divider()
            ShiftDetailsContentView(viewModel: $viewModel)
            Spacer()
        }
        .padding(.top, Constants.topPadding)
        .padding([.horizontal], Constants.horizonatalPadding)
    }
}

fileprivate struct ShiftDetailsHeaderView: View {
    @Binding var viewModel: ShiftViewModelProtocol
    
    var body: some View {
        VStack(spacing: Constants.horizontalSpacing) {
            Text(viewModel.shift.facilityType.name)
                .font(.headline)
                .foregroundColor(.gray)
            Text(viewModel.shift.shiftKind)
                .font(.footnote)
                .foregroundColor(.gray)
            HStack {
            Text(viewModel.shift.startTime.dateAsString)
                Text("\(viewModel.shift.startTime.hourMin) - \(viewModel.shift.endTime.hourMin)")
            }
                .font(.footnote)
                .foregroundColor(.blue)
        }
    }
}

fileprivate struct ShiftDetailsContentView: View {
    @Binding var viewModel: ShiftViewModelProtocol
    
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading, spacing: Constants.horizontalSpacing) {
                Text(viewModel.shift.localizedSpecialty.name)
                Text(viewModel.shift.skill.name)
                Text(viewModel.shift.localizedSpecialty.specialty.name)
            }
            Spacer()
            VStack(alignment: .leading, spacing: Constants.horizontalSpacing) {
                Text("Distance: \(viewModel.shift.withinDistance) mil")
                Text("Premium rate: \(viewModel.shift.premiumRate.asString)")
                Text("Covid: \(viewModel.shift.covid.asString)")
            }
        }
        .font(.subheadline)
        .foregroundColor(.gray)
    }
}


struct ShiftDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftDetailsView(
            viewModel: ShiftViewModel(
                shift: AvailableShifts.sample.data[0].shifts[0]
            )
        )
    }
}
