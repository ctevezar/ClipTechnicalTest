//
//  Reddit.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 08/06/2024.
//

import Foundation

enum Reddit {
    // MARK: Use cases
    enum FetchTopPosts {
        struct Request {
        }
        struct Response {
            var posts: [Post]?
        }
        struct ViewModel {
            struct DisplayedPost {
                var title: String?
                var imageUrl: URL?
                var subreddit: String?
            }
            var displayedPosts: [DisplayedPost]
        }
    }
}
