//
//  RedditTopPostsPresenter.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 05/06/2024.
//

import Foundation

protocol RedditTopPostsPresentationLogic {
    func presentFetched(posts: RedditResponse?)
}

class RedditTopPostsPresenter: RedditTopPostsPresentationLogic {
    func presentFetched(posts: RedditResponse?) {
        let titles = getTitles(from: posts)
        let list = toList(bullet: "•", elements: titles)
        
        // TODO: Esto podria llamar al VC para enviarle la data.
        print(list)
    }
    
    private func getTitles(from posts: RedditResponse?) -> [String] {
        guard let posts = posts?.data.children
        else { return [] }
        
        var titles = [String]()
        
        for post in posts {
            titles.append(post.data.title)
        }
        
        return titles
    }
    
    private func toList(bullet: Character, elements: [String]) -> String {
        var result = ""
        
        for element in elements {
            result += "\(bullet) \(element) \n"
        }
        
        return result
    }
}
