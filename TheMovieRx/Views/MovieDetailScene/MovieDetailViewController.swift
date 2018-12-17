//
//  MovieDetailViewController.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 16/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieTitle:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        guard let title = movieTitle else { return }
        self.title = title
    }
    @IBAction func onTapExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
