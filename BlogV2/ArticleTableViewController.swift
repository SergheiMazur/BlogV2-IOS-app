//
//  ArticleTableViewController.swift
//  BlogV2
//
//  Created by Serghei Mazur on 2018-05-25.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    fileprivate var articles: [Article]? = []
    fileprivate let identifer = "ArticleCell"
    fileprivate var serverData: Array<Dictionary<String, Any>> = []
    var endListArticles : Bool = false
    var pageID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Articles"
        if ((articles?.count)! < 1) {
            getNewPage()
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as! ArticleTableViewCell
        guard let articles = articles else { return cell }
        
        cell.articleNameLabel?.text = articles[(indexPath as NSIndexPath).row].title
        cell.articleShortVersionLabel?.text = getShort(dateString: articles[(indexPath as NSIndexPath).row].description!, symbols: 22)
        cell.dateLabel?.text = getShort(dateString: articles[(indexPath as NSIndexPath).row].created_at!, symbols: 9)
        if !endListArticles && (articles[articles.count - 1] === articles[(indexPath as NSIndexPath).row]) {
            getNewPage()
        }
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticle" {
            if let cell = sender as? ArticleTableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let selectedArticle = segue.destination as? DetailViewController {
                selectedArticle.article = articles?[(indexPath as NSIndexPath).row]
            }
        }
    }
    
    func getNewPage() {
        pageID += 1
        getArticlesFromServer(pageNumber: pageID)
    }

    func getShort(dateString: String, symbols: Int)-> String {
        if symbols < dateString.count{
            let firstPart = dateString.index(dateString.startIndex, offsetBy: symbols)
            return String(dateString[...firstPart])
        } else {
            return dateString
        }
    }
    
    func getArticlesFromServer(pageNumber: Int) {
        
        var getURL = URL(string: "https://alpha-blog-serhio.herokuapp.com/articles.json?page=\(pageNumber)")!
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: getRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil { print("GET Request: Communication error: \(error!)") }
            if data != nil {
                do {
                    let resultObject = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
                    DispatchQueue.main.async(execute: {
                        self.serverData = resultObject
                        if self.serverData.count < 5 {
                            self.endListArticles = true
                        }
                        for articleJSON in self.serverData {
                            let artricle: Article = Article(id: (articleJSON["id"] as? Int)!, title: (articleJSON["title"] as? String)!, description: (articleJSON["description"] as? String)!, created_at: (articleJSON["created_at"] as? String)!, updated_at: (articleJSON["updated_at"] as? String)!, user_id: (articleJSON["user_id"] as? Int)!)
                            self.articles?.append(artricle)
                        }
                        print("Download page number \(self.pageID)")
                        self.tableView.reloadData()
                    })

                } catch {
                    DispatchQueue.main.async(execute: {
                        print("Unable to parse JSON response")
                    })
                }
            } else {
                DispatchQueue.main.async(execute: {
                    print("Received empty response.")
                })
            }
        }).resume()
        
    }
}

