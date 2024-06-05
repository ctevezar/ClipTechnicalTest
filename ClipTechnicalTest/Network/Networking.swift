//
//  Networking.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 05/06/2024.
//

import Foundation

protocol Networking {
    func request<T: Decodable>(endpoint: String) async throws -> T
}

class NetworkingUrlSession: Networking {
    func request<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        else { throw NetworkError.badUrl }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let fetchedData = try JSONDecoder().decode(T.self, from: try mapResponse(response: (data, response)))
        
        return fetchedData
    }
    
    func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300: return response.data
        case 400:       throw NetworkError.badRequest
        case 401:       throw NetworkError.unauthorized
        case 402:       throw NetworkError.paymentRequired
        case 403:       throw NetworkError.forbidden
        case 404:       throw NetworkError.notFound
        case 413:       throw NetworkError.requestEntityTooLarge
        case 422:       throw NetworkError.unprocessableEntity
        default:        throw NetworkError.http(httpResponse: httpResponse, data: response.data)
        }
    }
}
