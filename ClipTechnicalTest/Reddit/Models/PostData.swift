//
//  PostData.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 05/06/2024.
//

struct PostData: Codable {
    let title: String
    let thumbnailUrl: String?
    let subreddit: String?
}

extension PostData {
    enum CodingKeys: String, CodingKey {
        
        case title
        case thumbnailUrl = "thumbnail"
        case subreddit = "subreddit_name_prefixed"
    }
}
