//
//  RedditTopPostsPresenter.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 05/06/2024.
//

import UIKit

protocol RedditTopPostsPresentationLogic {
    func presentFetched(posts: Reddit.FetchTopPosts.Response)
}

class RedditTopPostsPresenter: RedditTopPostsPresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentFetched(posts: Reddit.FetchTopPosts.Response) {
        let displayedPosts = getTitles(from: posts.posts)
        let viewModel = Reddit.FetchTopPosts.ViewModel(displayedPosts: displayedPosts)
        
        viewController?.displayPosts(viewModel: viewModel)
    }
    
    private func getTitles(from posts: [Post]?) -> [Reddit.FetchTopPosts.ViewModel.DisplayedPost] {
        guard let posts = posts
        else { return [] }
        
        var displayedPosts = [Reddit.FetchTopPosts.ViewModel.DisplayedPost]()
        
        for post in posts {
            
            let displayedPost = Reddit.FetchTopPosts.ViewModel.DisplayedPost(title: post.title,
                                                                             imageUrl: getUrl(from: post.thumbnailUrl),
                                                                             subreddit: post.subreddit)
            
            displayedPosts.append(displayedPost)
        }
        
        return displayedPosts
    }
    
    private func getUrl(from urlString: String?) -> URL? {
        guard let urlString = urlString
        else { return nil }
        
        let url = urlString.replacingOccurrences(of: "&amp;", with: "&")
        
        return URL(string: url)
    }
}
