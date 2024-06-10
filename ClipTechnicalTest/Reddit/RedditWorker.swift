//
//  RedditWorker.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 05/06/2024.
//

import Foundation

protocol RedditWorkerLogic {
    func fetchTopPosts() async throws -> [Post]?
}

class RedditWorker: RedditWorkerLogic {
    var network: Networking? = NetworkingUrlSession()
    
    func fetchTopPosts() async throws -> [Post]? {
        let url = Constants.Endpoints.topPosts
        let postsResponse: RedditResponse? = try await network?.request(endpoint: url)
        
        var posts = [Post]()
        
        for postData in postsResponse?.data.children ?? [] {
            let data = postData.data
            let post = Post(title: data.title,
                            thumbnailUrl: data.thumbnailUrl,
                            subreddit: data.subreddit)
            posts.append(post)
        }
        
        return posts
    }
}
