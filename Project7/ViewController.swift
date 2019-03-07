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
    var filteredPetitions = [Petititon]()
    
    
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetitions))
        
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            
        }else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
            
        }
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // do parse
                
                parseJson(json: data)
                
            }
        }
        
        
    }
    
    func filter(with word: String) {
        
        filteredPetitions.removeAll()
        
        for petition in petitions {
            
            if petition.title.contains(word) || petition.body.contains(word) {
                filteredPetitions.append(petition)
                
                
            }
        }
        
        tableView.reloadData()
        
        
        
    }
    
    @objc func filterPetitions() {
        
        let ac = UIAlertController(title: "Filter petitions", message:"Enter word to filter petitions" , preferredStyle: .alert)
        ac.addTextField()
        
        let filterAction = UIAlertAction(title: "Filter", style: .default) {
            [weak self, weak ac] _ in
            guard let word = ac?.textFields?[0].text else {return}
            self?.filter(with: word)
            
            
        }
        
        ac.addAction(filterAction)
        present(ac, animated: true, completion: nil)
        
        
    }
    
    @objc func showCredits() {
        
        let ac = UIAlertController(title: "Credits to", message: urlString , preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
        
        
    }
    
    func showError() {
        
        let ac = UIAlertController(title: "Loading error", message: "Error ocured while load data, please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(ac,animated: true)
        
        
    }
    
    func parseJson(json: Data) {
        
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
            
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredPetitions.count
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.recivedPetition = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
}

