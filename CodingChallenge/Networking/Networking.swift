//
//  Networking.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation
import Combine

protocol NetworkingProtocol {
    func get<Response: Decodable>(
        path: String,
        headers: [String: String],
        queryItems: [URLQueryItem]
    ) -> AnyPublisher<Response, Error>
}

final class Networking: NetworkingProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let backendConfiguration: NetworkConfigurationProtocol
    
    init(
        session: URLSession = .init(configuration: .default),
        backendConfiguration: NetworkConfigurationProtocol = StagingNetworkConfiguration(),
        decoder: JSONDecoder = JSONDecoder.shiftsDecoder
    ) {
        self.session = session
        self.backendConfiguration = backendConfiguration
        self.decoder = decoder
    }
    
    private func createURL(path: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = backendConfiguration.urlProtocol.value
        components.host = backendConfiguration.hostEndPoint
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
    
    func get<Response: Decodable>(
        path: String,
        headers: [String: String],
        queryItems: [URLQueryItem]
    ) -> AnyPublisher<Response, Error> {
        guard let url = createURL(path: path, queryItems: queryItems) else {
            return Fail(error: NetworkError.misformattedUrl).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        headers.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return session
            .dataTaskPublisher(for: request)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse else {
                    throw NetworkError.notValidHttpResponse
                }
                let statusCode = httpResponse.statusCode
                
                guard (200..<300).contains(statusCode) else {
                    switch statusCode {
                    case 300..<400:
                        throw NetworkError.unsuportedRedirection(statusCode: statusCode)
                    case 400..<500:
                        throw NetworkError.clientSideError(statusCode: statusCode)
                    case 500..<600:
                        throw NetworkError.serverSideError(statusCode: statusCode)
                    default:
                        throw NetworkError.unKnownError(statusCode: statusCode)
                    }
                }
                return response.data
            }
            .decode(type: Response.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
