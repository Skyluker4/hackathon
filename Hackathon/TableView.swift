//
//  TableResults.swift
//  Hackathon
//
//  Created by Ogden Wells on 11/20/21.
//

import Foundation
import UIKit
import Vision

class TableView: UIViewController {
    // Outlets

    @IBOutlet weak var dangerBar: UIView!
    @IBOutlet weak var photoView: UIImageView!

    @IBOutlet weak var theConstr: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    var image: UIImage!
    var signTitle: String!
    var signDescription: String = ""
    var danger: Int!
    var quit: Bool!
   
    
    // Overrides
    override func viewDidLoad() {
            photoView.image = image
            descriptionTextView.text = signDescription
        titleLabel.text = signTitle
            theConstr.constant = dangerBar.frame.size.width * CGFloat(danger) / 3.0 +  dangerBar.frame.size.width / 6.0
    }
}
