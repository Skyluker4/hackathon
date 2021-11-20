import Foundation
import UIKit
import Vision

class ResultsView: UIViewController {
	// Outlets
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var dangerBar: UIView!
    @IBOutlet weak var sliderBar: UIImageView!
    @IBOutlet weak var sliderBarConstraint: NSLayoutConstraint!
    // Variables
	var image: UIImage!
	var results: [VNClassificationObservation]!
   
	// Overrides
	override func viewDidLoad() {
		guard let firstObservation = results.first else {return}
        
		// Confidence at least 60%
		if(firstObservation.confidence >= 0.6) {
            let foundSign = Sign.findSign(id: String(firstObservation.identifier))

            photoView.image = UIImage(named: foundSign.id)
			resultLabel.text = foundSign.title + " - " + String(firstObservation.confidence * 100).prefix(2) + "%"
			descriptionTextView.text = foundSign.description
            
            sliderBarConstraint.constant = dangerBar.frame.size.width * CGFloat(foundSign.danger) / 3.0 +  dangerBar.frame.size.width / 6.0
        } else {
            photoView.image = image
			resultLabel.text = "No sign found."
			descriptionTextView.text = "Try again."
		}
	}
    
    override func viewDidDisappear(_ animated: Bool) {
        ViewController.resultsAreOpen = false
    }
}
