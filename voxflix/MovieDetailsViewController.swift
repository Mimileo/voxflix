//
//  MovieDetailsViewController.swift
//  voxflix
//
//  Created by Mireya Leon on 9/8/20.
//  Copyright © 2020 mireyaleon76. All rights reserved.
//

import UIKit
import AlamofireImage
import WebKit

class MovieDetailsViewController: UIViewController {
   
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    
    var movie: [String: Any]! // swift oprtionals
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        // print(movie["title"] ?? "")
     
        
        // cast to string
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        let baseUrl = "https://image.tmdb.org/t/p/w185"
               let posterPath = movie["poster_path"] as! String
               let posterUrl = URL(string: baseUrl + posterPath)
               
               posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
    
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
          print("Loading the details screen")
          
          // find the selected movie
          let selectedMovie = movie
          
          // pass selected movie to trailer view controller
          // segue.destination returns View controller so downcast to TrailerViewController
          let trailerViewController = segue.destination as! TrailerViewController
          // set the movie property of th details view controller
          trailerViewController.movie = selectedMovie
          
          // when transitioning do leave highlighted
          //collectionView.deselectRow(at: indexPath, animated: true)
    }


}
