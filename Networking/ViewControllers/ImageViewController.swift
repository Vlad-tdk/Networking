//
//  ViewController.swift
//  Networking
//
//  Created by Vlad on 6.8.23..
//

import UIKit

final class ImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }

    private func fetchImage() {
        guard let url = URL(string: Link.imageURL.rawValue) else { return }
                
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            print(response)
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.activityIndicator.stopAnimating()
            }
            
        }.resume()
    }

}

