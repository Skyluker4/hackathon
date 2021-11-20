import Foundation

struct Sign {
	// Array of all of the contacts
	static var Signs: [Sign] = [
		Sign(id: "ghs_explosion", title: "Explosive Material", description: "Materials that will combust at high temperatures or from extreme changes in momentum.(ie. glycerin, hydrogen, gasoline)", danger: 2),
		Sign(id: "ghs_flammable", title: "Flammable Matter", description: "Flammable gasses, aerosols, liquids, and substances. Commonly used in places that experience abnormally dry conditions", danger: 1),
		Sign(id: "ghs_oxidizing", title: "Oxidizing Agent", description: "Oxidizing solids, liquids, and gasses.", danger: 0),
		Sign(id: "ghs_compressed_gas", title: "Compressed Gas", description: "Compressed, liquefied, and dissolved gasses.", danger: 0),
		Sign(id: "ghs_corrosive", title: "Corrosive", description: "Corrosive, dissolves through organic/non organic materials.", danger: 1),
		Sign(id: "ghs_toxic", title: "Toxic", description: "Warns of danger, usually in regard to poisonous substances, such as deadly chemicals.", danger: 1),
		Sign(id: "ghs_harmful", title: "Harmful", description: "Acute toxicity, irritating, or toxic to organs.", danger: 1),
		Sign(id: "ghs_health_hazard", title: "Health Hazard", description: "Respiratory sensitization, carcinogentic, or toxic.", danger: 1),
		Sign(id: "ghs_environmental_hazard", title: "Environmental Hazard", description: "Hazards to the aquatic environment or environmental toxicity.", danger: 0),
		Sign(id: "carcinogen", title: "Carcinogen", description: "A carcinogen is any substance, radionuclide, or radiation that promotes carcinogenesis, the formation of cancer. This may be due to the ability to damage the genome or to the disruption of cellular metabolic processes. Several radioactive substances are considered carcinogens, but their carcinogenic activity is attributed to the radiation, for example gamma rays and alpha particles, which they emit.", danger: 2),
		Sign(id: "general_caution", title: "General Caution", description: "General warning signs are used in instances in which the particular hazard, obstacle or condition is not covered by a standard sign.", danger: 0),
		Sign(id: "ionizing_radiation", title: "Ionizing Radiation", description: "Ionizing (or ionising) radiation consists of subatomic particles or electromagnetic waves that have sufficient energy to ionize atoms or molecules by detaching electrons from them.[1] The particles generally travel at a speed that is greater than 1% of that of light, and the electromagnetic waves are on the high-energy portion of the electromagnetic spectrum.", danger: 2),
		Sign(id: "laser", title: "Laser", description: "Today, it is accepted that even low-power lasers with only a few milliwatts of output power can be hazardous to human eyesight when the beam hits the eye directly or after reflection from a shiny surface. At wavelengths which the cornea and the lens can focus well, the coherence and low divergence of laser light means that it can be focused by the eye into an extremely small spot on the retina, resulting in localized burning and permanent damage in seconds or even less time.", danger: 1),
		Sign(id: "non_ionizing_radiation", title: "Non-Ionizing Radiation", description: "Non-ionizing (or non-ionising) radiation refers to any type of electromagnetic radiation that does not carry enough energy per quantum (photon energy) to ionize atoms or molecules�that is, to completely remove an electron from an atom or molecule.[1] Instead of producing charged ions when passing through matter, non-ionizing electromagnetic radiation has sufficient energy only for excitation (the movement of an electron to a higher energy state).", danger: 1),
        Sign(id: "logo", title: "Logo", description: "Hey, that's us!", danger: 2)
	]

	// Static functions
	static func findSign(id: String) -> Sign {
		for sign in Signs {
			if sign.id == id {
				return sign
			}
		}
		return Sign(id: "", title: "Sign Not Found", description: "Sign not found.", danger: 0)
	}

	// Variables
	var id: String
	var title: String
	var description: String
	var danger: Int

	init(id: String, title: String, description: String, danger: Int) {
		self.id = id
		self.title = title
		self.description = description
		self.danger = danger
	}
}
