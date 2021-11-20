import Foundation
import UIKit
import Vision

class ResultView: UIViewController {
	// Outlets
	@IBOutlet weak var photoView: UIImageView!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var resultLabel: UILabel!

	// Variables
	var image: UIImage!
	var results: [VNClassificationObservation]!

	// Overrides
	override func viewDidLoad() {
		photoView.image = image

		guard let firstObservation = results.first else {return}

		// Confidence greater than 80%
		if(firstObservation.confidence >= 0.8) {
			resultLabel.text = firstObservation.identifier + " - " + String(firstObservation.confidence * 100).prefix(2) + "%"

			var foundSign = Sign.findSign(id: String(firstObservation.identifier))

			descriptionTextView.text = foundSign.description
		} else {
			resultLabel.text = "No sign found."
			descriptionTextView.text = "Try again."
		}
	}
}
