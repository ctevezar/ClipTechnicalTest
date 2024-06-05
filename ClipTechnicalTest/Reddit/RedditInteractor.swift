//
//  RedditInteractor.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 05/06/2024.
//

import Foundation
import UIKit

protocol RedditTopPostsBusinessLogic {
    func fetchTopPosts()
}

protocol RedditTopPostsDataStore {
    var posts: RedditResponse? { get }
}

class RedditTopPostsInteractor: RedditTopPostsBusinessLogic, RedditTopPostsDataStore {
    var presenter: RedditTopPostsPresentationLogic = RedditTopPostsPresenter()
    var worker: RedditServiceProtocol = RedditService()
    var posts: RedditResponse?
    
    func fetchTopPosts() {
        Task {
            do {
                let result = try await worker.fetchTopPosts()
                self.posts = result
                self.presenter.presentFetched(posts: result)
            } catch let error {
                print(error.localizedDescription.description)
            }
        }
        
    }
}
