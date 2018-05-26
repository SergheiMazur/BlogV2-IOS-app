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
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
