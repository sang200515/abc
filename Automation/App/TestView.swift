import SwiftUI

struct TestView: View {
    @State private var searchText = ""
    @State private var selectedResult: Int?
    @State var list = Array(1...10)
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {

                }) {
                    Text("Search")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding()

            Spacer()

            Text("Search Results")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .onChange(of: searchText) { newValue in

                }

            List(selection: $selectedResult) {
                ForEach(list, id: \.self) { number in
                    Text("Result \(number)")
                        .tag(number)
                }
            }
            .padding(.horizontal)
        }
        .onChange(of: selectedResult) { newValue in
            if let selected = newValue {
                print("Selected item: Result \(selected)")
            }
        }
    }
}
