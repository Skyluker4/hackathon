//
//  ReferenceView.swift
//  Hackathon
//
//  Created by Ogden Wells on 11/20/21.
//

import Foundation
import UIKit

class ReferenceView : UITableViewController {
    // Functions
    // Set up the view controller
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    var row: Int!
    
    // Table View
    // Get how many cells to create; based on how many items in menu
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sign.Signs.count - 1
    }
    // Load Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create cell
        let cell: SignCell = tableView.dequeueReusableCell(withIdentifier: "signCell", for: indexPath as IndexPath) as! SignCell

        let sign = Sign.Signs[indexPath.row]

        // Save Item to cell
        cell.name.text = sign.title
        cell.cellImage.image = UIImage(named: sign.id)

        // Return formatted cell
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Result
        if segue.destination is TableView {
            let vc = segue.destination as? TableView
            vc?.image = UIImage(named: Sign.Signs[row].id)
            vc?.title = Sign.Signs[row].title
            vc?.signDescription = Sign.Signs[row].description
            vc?.danger = Sign.Signs[row].danger
                vc?.quit = false
            
        }
    
    }
    
    // Handle input
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        row = indexPath.row
        
        performSegue(withIdentifier: "TableResultSeg", sender: self)

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// Class for each individual contact cell
class SignCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var name: UILabel!
}
