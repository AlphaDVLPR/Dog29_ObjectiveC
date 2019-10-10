//
//  BreedsListTableViewController.swift
//  Dogs_ObjectiveC
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import UIKit

class BreedsListTableViewController: UITableViewController {

    //MARK: - Global Variables
    var breeds: [JRC_Breed] = []
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        JRC_BreedNetworkClient.shared().fetchAllBreeds({ (breeds) in
            guard let breeds = breeds else {print("There was a problem populating the tableview"); return}
            DispatchQueue.main.async {
                self.breeds = breeds
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)

        let breed = breeds[indexPath.row]
        cell.textLabel?.text = breed.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let breed = breeds[indexPath.row]
        if breed.subBreeds.count > 0 {
            performSegue(withIdentifier: "toSubBreedVC", sender: self)
        } else {
            performSegue(withIdentifier: "toCollectionVC", sender: self)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toSubBreedVC" {
            
        }
        
        if segue.identifier == "toCollectionVC" {
            
        }
    }
}
