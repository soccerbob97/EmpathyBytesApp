import SwiftUI

struct ARGameMenu: View {
    
    var body: some View {
        VStack(spacing:20) {
            Text("Makerspace Games")
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            HStack(spacing:20) {
                NavigationLink(destination: ARMatchGameModelView()) {
                    Text("Match!")
                        .fontWeight(.bold)
                        .font(.custom("Georgia", size: 25))
                        .padding()
                        .background(Color(red: 0 / 255, green: 48 / 255, blue: 87 / 255))
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color(red: 0 / 255, green: 48 / 255, blue: 87 / 255), lineWidth: 5)
                        )
                }
                NavigationLink(destination: ARMatchGameModelView()) {
                    Text("Game2")
                        .fontWeight(.bold)
                        .font(.custom("Georgia", size: 25))
                        .padding()
                        .background(Color(red: 0 / 255, green: 48 / 255, blue: 87 / 255))
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color(red: 0 / 255, green: 48 / 255, blue: 87 / 255), lineWidth: 5)
                        )
                }
                
            }
            Spacer()
        }
    }
}

struct ARGameMenu_Previews: PreviewProvider {
    static var previews: some View {
        ARGameMenu()
    }
}
