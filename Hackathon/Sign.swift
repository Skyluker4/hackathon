import Foundation

struct Sign {
	// Array of all of the contacts
	static var Signs: [Sign] = [
		Sign(id: "ghs_explosion", title: "Explosive Material", description: "Materials that will combust at high temperatures or from extreme changes in momentum.(ie. glycerin, hydrogen, gasoline)"),
		Sign(id: "ghs_flammable", title: "Flammable Matter", description: "Flammable gasses, aerosols, liquids, and substances. Commonly used in places that experience abnormally dry conditions"),
		Sign(id: "ghs_oxidizing", title: "Oxidizing Agent", description: "Oxidizing solids, liquids, and gasses."),
		Sign(id: "ghs_compressed_gas", title: "Compressed Gas", description: "Compressed, liquefied, and dissolved gasses."),
		Sign(id: "ghs_corrosive", title: "Corrosive", description: "Corrosive, dissolves through organic/non organic materials."),
		Sign(id: "ghs_toxic", title: "Toxic", description: "Acute toxicity"),
		Sign(id: "ghs_harmful", title: "Harmful", description: "Acute toxicity, irritating, or toxic to organs."),
		Sign(id: "ghs_health_hazard", title: "Health Hazard", description: "Respiratory sensitization, carcinogentic, or toxic."),
		Sign(id: "ghs_environmental_hazard", title: "Environmental Hazard", description: "Hazards to the aquatic environment or environmental toxicity.")
	]

	// Static functions
	static func findSign(id: String) -> Sign {
		for sign in Signs {
			if sign.id == id {
				return sign
			}
		}
		return Sign(id: "", title: "Sign Not Found", description: "Sign not found.")
	}

	// Variables
	var id: String
	var title: String
	var description: String

	init(id: String, title: String, description: String) {
		self.id = id
		self.title = title
		self.description = description
	}
}
