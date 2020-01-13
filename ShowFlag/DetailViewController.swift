//
//  DetailViewController.swift
//  ShowFlag
//
//  Created by alexander on 17.10.2019.
//  Copyright © 2019 alexander. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var seletedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = seletedImage {
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.largeTitleDisplayMode = .never
        guard let fileName = seletedImage else {
            print("FileName is empty")
            return
        }
        let endOfFileName = fileName.lastIndex(of: ".")!
        title = String(fileName[..<endOfFileName]).uppercased()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        guard let imageName = seletedImage else {
            print("No image found")
            return
        }

        let vc = UIActivityViewController(activityItems: [imageName, image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
