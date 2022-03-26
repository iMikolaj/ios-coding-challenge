//
//  Networking.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation
import Combine

protocol ShiftsNetworkingProtocol {
    func fetchAvailableShifts(
        address: String,
        startDate: Date,
        endDate: Date?,
        radius: Int,
        type: ShiftsResultType
    ) -> AnyPublisher<AvailableShifts, Error>
}

enum ShiftsResultType: String {
    case week
    case fourDays = "4day"
    case list
}

final class ShiftsNetworking: ShiftsNetworkingProtocol {
    private let networking:  NetworkingProtocol
    private let deafultHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    init(networking: NetworkingProtocol = Networking()) {
        self.networking = networking
    }
    
    func fetchAvailableShifts(
        address: String,
        startDate: Date,
        endDate: Date?,
        radius: Int,
        type: ShiftsResultType
    ) -> AnyPublisher<AvailableShifts, Error> {
        var query = [URLQueryItem]()
        query.append(URLQueryItem(name: "type", value: type.rawValue))
        query.append(URLQueryItem(name: "address", value: address))
        query.append(URLQueryItem(name: "start", value: startDate.dateAsString))
        query.append(URLQueryItem(name: "radius", value: String(radius)))
        
        if let endDate = endDate, type == .list {
            query.append(URLQueryItem(name: "end", value: endDate.dateAsString))
        }
        
        return networking.get(
            path: "/api/v2/available_shifts",
            headers: deafultHeaders,
            queryItems: query
        )
    }
}






