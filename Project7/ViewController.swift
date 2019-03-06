//
//  ViewController.swift
//  Project7
//
//  Created by Stefan Milenkovic on 3/6/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petititon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let urlString = URL(string: "https://www.hackingwithswift.com/samples/petitions-1.json")
        if let url = urlString {
            if let data = try? Data(contentsOf: url) {
                // do parse
                
                parseJson(json: data)
            }
        }
        
        
    }
    
    func parseJson(json: Data) {
        
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            
            petitions = jsonPetitions.results
            tableView.reloadData()
            
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }

    
    

}

