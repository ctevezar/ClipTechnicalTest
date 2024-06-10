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
    var posts: [Post]? { get }
}

class RedditTopPostsInteractor: RedditTopPostsBusinessLogic, RedditTopPostsDataStore {
    var presenter: RedditTopPostsPresentationLogic = RedditTopPostsPresenter()
    var worker: RedditWorkerLogic = RedditWorker()
    var posts: [Post]?
    
    func fetchTopPosts() {
        Task {
            do {
                let result = try await worker.fetchTopPosts()
                self.posts = result
                let response = Reddit.FetchTopPosts.Response(posts: result)

                self.presenter.presentFetched(posts: response)
            } catch let error {
                print(error.localizedDescription.description)
            }
        }
    }
}
