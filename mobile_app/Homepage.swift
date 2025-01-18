import SwiftUI

struct Homepage: View {
    @State private var showAlert = false
    @State private var isConfirmed = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("香港歷史保育建築")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)

                    // Clickable Image
                    Image("heritageBuilding") // Use the image name added in Assets
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .onTapGesture {
                            showAlert = true // Show confirmation alert when tapped
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("確認"),
                                message: Text("你確定要前往網站嗎？"),
                                primaryButton: .default(Text("Yes")) {
                                    // Open URL if confirmed
                                    if let url = URL(string: "https://www.heritage.gov.hk/tc/home/index.html") {
                                        UIApplication.shared.open(url)
                                    }
                                },
                                secondaryButton: .cancel(Text("No")) {
                                    // Do nothing if cancelled
                                }
                            )
                        }

                    Text("香港擁有豐富的歷史和文化，其建築物不僅反映了城市的演變，也見證了社會的變遷。保育這些歷史建築不僅是對過去的尊重，也是對未來的承諾。")
                        .font(.body)
                        .padding()

                    Text("保育的文化意義")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("保育歷史建築能夠保存我們的文化遺產，讓後代了解和體驗過去的生活方式和價值觀。這些建築物是我們身份的一部分，提醒我們珍惜和保護我們的文化根源。")
                        .font(.body)
                        .padding()

                    Text("保育的歷史作用")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("透過保育，我們能夠維護社區的歷史記憶，促進社會凝聚力。這些建築物不僅是旅遊景點，更是社區活動和文化交流的重要場所。保護它們意味著我們在延續香港獨特的歷史和文化。")
                        .font(.body)
                        .padding()

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Homepage")
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
