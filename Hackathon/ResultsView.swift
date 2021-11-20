import Foundation
import UIKit
import Vision

class ResultsView: UIViewController {
	// Outlets
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var sliderBar: UIImageView!
    // Variables
	var image: UIImage!
	var results: [VNClassificationObservation]!
   
	// Overrides
	override func viewDidLoad() {
		guard let firstObservation = results.first else {return}
        
		// Confidence at least 80%
		if(firstObservation.confidence >= 0.7) {
            let foundSign = Sign.findSign(id: String(firstObservation.identifier))

            photoView.image = UIImage(named: foundSign.id)
			resultLabel.text = foundSign.title + " - " + String(firstObservation.confidence * 100).prefix(2) + "%"
			descriptionTextView.text = foundSign.description
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
