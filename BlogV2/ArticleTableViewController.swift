//
//  ArticleTableViewController.swift
//  BlogV2
//
//  Created by Serghei Mazur on 2018-05-25.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    fileprivate var articles: [ArticleStr] = []
    fileprivate let identifer = "ArticleCell"
    var endListArticles : Bool = false
    var pageID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Articles"
        if ((articles.count) < 1) {
            getNewPage()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as! ArticleTableViewCell
        
        cell.articleNameLabel?.text = articles[(indexPath as NSIndexPath).row].title
        cell.articleShortVersionLabel?.text = getShort(dateString: articles[(indexPath as NSIndexPath).row].description, symbols: 22)
        cell.dateLabel?.text = getShort(dateString: articles[(indexPath as NSIndexPath).row].created_at, symbols: 9)
        if !endListArticles && ((indexPath as NSIndexPath).row == articles.count - 1) {
            getNewPage()
        }
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticle" {
            if let cell = sender as? ArticleTableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let selectedArticle = segue.destination as? DetailViewController {
                let articleTitle = articles[(indexPath as NSIndexPath).row].title
                let articleDescription = articles[(indexPath as NSIndexPath).row].description
                let articleCreatedAt = articles[(indexPath as NSIndexPath).row].created_at
                    
                selectedArticle.article = Article(id: 0, title: articleTitle, description: articleDescription, created_at: articleCreatedAt, updated_at: "", user_id: 0)
        
            }
        }
    }
    
    func getNewPage() {
        pageID += 1
        let url = "https://alpha-blog-serhio.herokuapp.com/articles.json?page=\(pageID)"
        fetchGenericData (urlString: url){ (data: [ArticleStr]) in
            data.forEach({print($0.title, $0.description); if data.count < 5 {self.endListArticles = true};self.articles.append($0)})
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }
        
    }

    func getShort(dateString: String, symbols: Int)-> String {
        if symbols < dateString.count{
            let firstPart = dateString.index(dateString.startIndex, offsetBy: symbols)
            return String(dateString[...firstPart])
        } else {
            return dateString
        }
    }
    
    
    fileprivate func fetchGenericData<T: Decodable> (urlString: String, completion: @escaping (T) -> ()) {
        let urlString = urlString
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            guard let data = data else {return}
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let jsonErr {
                print ("Failed to decode json", jsonErr)
            }
        }.resume()
    }
    
    
    struct ArticleStr: Decodable {
        let id: Int
        let title: String
        let description: String
        let created_at: String
        let updated_at: String
        let user_id: Int
    }
}

