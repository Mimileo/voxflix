//
//  TrailerViewController.swift
//  voxflix
//
//  Created by Mireya Leon on 9/15/20.
//  Copyright © 2020 mireyaleon76. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var movie: [String: Any]!
    var videos = [[String:Any]]()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Showing trailer for.. ")
        print(movie["id"] ?? "")
        let movie_id = movie["id"] as? NSNumber
        let videoUrl = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id!.stringValue)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
               let request = URLRequest(url: videoUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
               let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
               let task = session.dataTask(with: request) { (data, response, error) in
                  // This will run when the network request returns
                  if let error = error {
                     print(error.localizedDescription)
                  } else if let data = data {
                     let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                     // TODO: Get the array of movies
                    //print(dataDictionary)
                
                    self.videos = dataDictionary["results"] as! [[String:Any]]
                    
                    //print(self.videos)
                    print(self.videos[0]["key"] as! String)
                    let base_video = "https://www.youtube.com/watch?v="
                    let movie_key = self.videos[0]["key"] as! String
                    let trailerUrl = URL(string:base_video + movie_key)
                    let myRequest = URLRequest(url: trailerUrl!)
                    self.webView.load(myRequest)

                   
                  }
               }
               task.resume()
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
