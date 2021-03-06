//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Grace Leung on 2/21/20.
//  Copyright © 2020 Grace Leung. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var photosView: UITableView!
    var posts: [[String: Any]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosView.delegate = self
        photosView.dataSource = self
        
        
        //Network Request Snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data,
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            
            let responseDictionary = dataDictionary["response"] as! [String: Any]
            self.posts = responseDictionary["posts"] as! [[String: Any]]
            
            print(dataDictionary)

              // TODO: Get the posts and store in posts property

              // TODO: Reload the table view
          }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosCell", for: indexPath) as! photosCell
        
        cell.rowname.text = "This is row \(indexPath.row)"

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
