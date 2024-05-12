import SwiftUI
import Combine

class SharedDataModel: ObservableObject {
	@Published var name: String = ""
	@Published var gender: String = ""
	@Published var dob: String = ""
	
	@Published var careof: String = ""
	@Published var house: String = ""
	@Published var street: String = ""
	
	@Published var landmark: String = ""
	@Published var po: String = ""
	@Published var loc: String = ""
	
	@Published var subdist: String = ""
	@Published var state: String = ""
	@Published var country: String = ""
	
	@Published var pc: String = ""
	
	func saveData(name: String, gender: String, dob: String) {
		print("saving data")
		UserDefaults.standard.set(name, forKey: "name")
		UserDefaults.standard.set(gender, forKey: "gender")
		UserDefaults.standard.set(dob, forKey: "dob")
		
		UserDefaults.standard.set(name, forKey: "careof")
		UserDefaults.standard.set(gender, forKey: "house")
		UserDefaults.standard.set(dob, forKey: "street")
		
		UserDefaults.standard.set(name, forKey: "landmark")
		UserDefaults.standard.set(gender, forKey: "po")
		UserDefaults.standard.set(dob, forKey: "loc")
		
		UserDefaults.standard.set(name, forKey: "subdist")
		UserDefaults.standard.set(gender, forKey: "state")
		UserDefaults.standard.set(dob, forKey: "country")
		
		UserDefaults.standard.set(name, forKey: "pc")
		fetchSavedData()
	}
	
	func fetchSavedData() {
		name = UserDefaults.standard.string(forKey: "name") ?? ""
		gender = UserDefaults.standard.string(forKey: "gender") ?? ""
		dob = UserDefaults.standard.string(forKey: "dob") ?? ""
		
		careof = UserDefaults.standard.string(forKey: "careof") ?? ""
		house = UserDefaults.standard.string(forKey: "house") ?? ""
		street = UserDefaults.standard.string(forKey: "street") ?? ""
		
		landmark = UserDefaults.standard.string(forKey: "landmark") ?? ""
		po = UserDefaults.standard.string(forKey: "po") ?? ""
		loc = UserDefaults.standard.string(forKey: "loc") ?? ""
		
		subdist = UserDefaults.standard.string(forKey: "subdist") ?? ""
		state = UserDefaults.standard.string(forKey: "state") ?? ""
		country = UserDefaults.standard.string(forKey: "country") ?? ""
		
		pc = UserDefaults.standard.string(forKey: "pc") ?? ""
	}
}


struct pictureView: View {
	@State private var base64String: String = ""

	var body: some View {
		VStack {
			if let image = decodeBase64String(base64String) {
				// If image decoding is successful, display it
				Image(uiImage: image)
					.resizable()
					.scaledToFit()
					.frame(width: 200, height: 200)
			} else {
				// If decoding fails, display an error message
				Text("Aadhar card file corrupted. Try again")
			}
		}
		.onAppear {
			fetchSavedData()
		}
	}

	// Function to decode base64 string to UIImage
	private func decodeBase64String(_ base64String: String) -> UIImage? {
		if let imageData = Data(base64Encoded: base64String) {
			return UIImage(data: imageData)
		} else {
			return nil
		}
	}

	// Function to fetch saved data
	private func fetchSavedData() {
		if let savedString = UserDefaults.standard.string(forKey: "encodedImage") {
			base64String = savedString
		}
	}
}

struct addressView: View {
	@ObservedObject var sharedDataModel: SharedDataModel
	var house: String = "5"
	var street: String = "BHARATHIYAR STREET"
	var landmark: String = "SAKTHI NAGAR PADI"
	var po: String = "Padi"
	var loc: String = "AMBATTUR"
	var subdist: String = "Ambattur"
	var state: String = "Tamil Nadu"
	var country: String = "India"
	var pc: String = "600050"
	
	var body: some View {
			VStack(alignment: .leading) {
				Text("Address").font(.subheadline)
				Text(fullAddressLine1)
				Text(fullAddressLine2)
				Text(fullAddressLine3)
				Text(pc)
			}
			.padding()
		}

		private var fullAddressLine1: String {
			sharedDataModel.careof + " " + house + " " + street
		}

		private var fullAddressLine2: String {
			landmark + ", " + loc + ", " + po + ", " + subdist
		}

		private var fullAddressLine3: String {
			state + " " + country
		}
}

struct NamesView: View {
	@ObservedObject var sharedDataModel: SharedDataModel
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Name").font(.subheadline)
			Text("\(sharedDataModel.name)").font(.title3).fontWeight(.semibold)
			Text("Gender").font(.subheadline)
			Text("\(sharedDataModel.gender)").font(.title3).fontWeight(.semibold)
			Text("DOB").font(.subheadline)
			Text("\(sharedDataModel.dob)").font(.title3).fontWeight(.semibold)
		}
		.onAppear {
			sharedDataModel.fetchSavedData()
		}
		.padding()
	}
}

struct AddingView: View {
	@ObservedObject var sharedDataModel: SharedDataModel
	@State private var name: String = ""
	@State private var gender: String = ""
	@State private var dob: String = ""
	@State private var careof: String = ""
	
	var body: some View {
		VStack {
			TextField("Name", text: $name)
			TextField("Gender", text: $gender)
			TextField("Date of Birth", text: $dob)
			
			TextField("careof", text: $careof)

			Button(action: {
				sharedDataModel.saveData(name: name, gender: gender, dob: dob)
			}) {
				Text("Save")
			}
		}
		.padding()
	}
}




struct ContentView: View {
	// Placeholder base64 string
	@State var title = "aadhar in wallet"
	@StateObject private var sharedDataModel = SharedDataModel()
	
	var body: some View {
		NavigationView {
		ZStack{
			LinearGradient(gradient: Gradient(colors: [Color.orange, Color.init(hue: 1, saturation: 0.7, brightness: 1)]), startPoint: .bottomLeading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).ignoresSafeArea()
			RoundedRectangle(cornerRadius: 10)
				.foregroundColor(.white)
				.opacity(0.7)
				.padding(10.0)
			VStack(alignment: .leading) {
				Text("XXXX XXXX XXXX 1234")
					.fontWeight(.heavy)
				HStack(alignment: .top) {
					pictureView()
						.cornerRadius(5)
					NamesView(sharedDataModel: sharedDataModel)
					}
				addressView(sharedDataModel: sharedDataModel)
				AddingView(sharedDataModel: sharedDataModel)
				
				Spacer()
				}
			.padding([.leading, .bottom, .trailing], 15)
			.padding(.top,20)
			
			}
		.navigationTitle(title)
		}
		
	}

}

// Preview code
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
