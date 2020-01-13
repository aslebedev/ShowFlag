//
//  ViewController.swift
//  ShowFlag
//
//  Created by alexander on 17.10.2019.
//  Copyright © 2019 alexander. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Show Flag"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // Returns numer of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    // Returns cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagName", for: indexPath)
        let fileName = flags[indexPath.row]
        let endOfFileName = fileName.lastIndex(of: ".")!
        cell.textLabel?.text = String(fileName[..<endOfFileName]).uppercased()
        return cell
    }
    
    // Row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.seletedImage = flags[indexPath.row]
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

