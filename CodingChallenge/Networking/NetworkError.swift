//
//  NetworkError.swift
//  CodingChallenge
//
//  Created by Mikolaj Kmita on 26/03/2022.
//

import Foundation

enum NetworkError: Error {
    case misformattedUrl
    case notValidHttpResponse
    case unsuportedRedirection(statusCode: Int)
    case clientSideError(statusCode: Int)
    case serverSideError(statusCode: Int)
    case addressNotFound(statusCode: Int)
    case unKnownError(statusCode: Int)
}
