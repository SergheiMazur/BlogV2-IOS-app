//
//  ArticleTableViewController.swift
//  BlogV2
//
//  Created by Serghei Mazur on 2018-05-25.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    fileprivate var articles: [Article]?
    fileprivate let identifer = "ArticleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articles = [
            Article(id: 1, title: "First article", description: "First description", created_at: "2018-05-12", updated_at: "2018-05-12", user_id: 3),
            Article(id: 2, title: "2 article", description: "2 description", created_at: "2018-05-14", updated_at: "2018-05-15", user_id: 3),
            Article(id: 3, title: "3 article", description: "3 description", created_at: "2018-05-17", updated_at: "2018-05-17", user_id: 3)
        ]
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
        cell.articleShortVersionLabel?.text = articles[(indexPath as NSIndexPath).row].description
        cell.dateLabel?.text = articles[(indexPath as NSIndexPath).row].created_at
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

    func getArticlesFromServer() {
        /*
        let URL = "https://   /articles.json"

        DispatchQueue.main.async{
                    
            self.articles =
            self.tableView.reloadData()
        }
        */
    }
}

