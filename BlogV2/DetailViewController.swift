//
//  DetailViewController.swift
//  BlogV2
//
//  Created by Serghei Mazur on 2018-05-25.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleBodyTextView: UITextView!
    @IBOutlet weak var articleCreatedDateLabel: UILabel!
    
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Article"
        articleTitleLabel.text = setLabel(articleText: article?.title)
        articleBodyTextView.text = setLabel(articleText: article?.description)
        articleCreatedDateLabel.text = setLabel(articleText: article?.created_at)
    }
    
    func setLabel(articleText: String?) -> String {
        if let articleText = articleText {
            return articleText
        } else {
            return "None"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}
