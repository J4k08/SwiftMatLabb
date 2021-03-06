//
//  TableViewController.swift
//  SwiftLabb1
//
//  Created by Jakob Haglöf on 2017-02-19.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController    {
    
    var jsonArray : [[String:Any]] = [[:]]
    var valueToPass : [String:Any] = [:]
    var nutritionData : [String:Any] = [:]
    var kcalValues : [String:Any] = [:]
    var kcal : [Int: Float] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableBackground = UIImage(named: "tomato")
        let imageView = UIImageView(image: tableBackground)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jsonArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCustomTableViewCell
        
        if let name = jsonArray[indexPath.row]["name"] as? String {
            cell.nameLabel.text = name
        }
        
        if let number = self.jsonArray[indexPath.row]["number"] as? Int {
            
            cell.numberOfRow = number
                
                if let kcal = self.kcal[number] {
                    cell.calorieLabel.text = "\(kcal) kal"
               
                } else {
                    searchQueryForCalories(number: number, gotNutritionData: recievedData)
                }
        }
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func recievedData(dictionary : [String:Any]){
        
        kcalValues = dictionary["nutrientValues"] as! [String : Any]
       
        kcal[(dictionary["number"] as? Int)!] = kcalValues["energyKcal"] as? Float!
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? MyCustomTableViewCell{
            let clickedCell = segue.destination as! ResultViewController
            clickedCell.recievedString = cell.nameLabel.text
            
            clickedCell.numberOfWare = cell.numberOfRow
            
        }
    }

}
