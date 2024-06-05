//
//  RedditService.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 05/06/2024.
//

import Foundation

protocol RedditServiceProtocol {
    func fetchTopPosts() async throws -> RedditResponse?
}

class RedditService: RedditServiceProtocol {
    var network: Networking? = NetworkingUrlSession()
    
    func fetchTopPosts() async throws -> RedditResponse? {
        let url = Constants.Endpoints.topPosts
        let topPosts: RedditResponse? = try await network?.request(endpoint: url)
        
        return topPosts
    }
}
