//
//  NetworkConfiguration.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation

enum NetworkProtocols: String {
    case https
    var value: String { rawValue }
}

protocol NetworkConfigurationProtocol {
    var urlProtocol: NetworkProtocols { get }
    var hostEndPoint: String { get }
}

final class StagingNetworkConfiguration: NetworkConfigurationProtocol {
    let urlProtocol = NetworkProtocols.https
    let hostEndPoint = "staging-app.shiftkey.com"
}
