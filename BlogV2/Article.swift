//
//  Article.swift
//  BlogV2
//
//  Created by Serghei Mazur on 2018-05-25.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import Foundation

class Article {
    var id: Int?
    var title: String?
    var description: String?
    var created_at: String?
    var updated_at: String?
    var user_id: Int?
    
    init(id: Int, title: String, description: String, created_at: String, updated_at: String, user_id: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.created_at = created_at
        self.updated_at = updated_at
        self.user_id = user_id
    }
    
}
