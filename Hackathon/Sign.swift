import Foundation

struct Sign {
	// Array of all of the contacts
	static var Signs: [Sign] = [
		Sign(id: "ghs_explosion", title: "USB Micro-B Male", description: "Commonly used to plug into devices"),
		Sign(id: "", title: "USB Type A Male", description: "Commonly used to plug into computes.")
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
