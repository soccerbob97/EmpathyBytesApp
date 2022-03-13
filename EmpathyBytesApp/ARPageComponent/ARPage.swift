//
//  ModelDescriptionView.swift
//  EmpathyBytesApp
//
//  Created by Harsha Karanth on 11/8/21.
//

import SwiftUI

struct ARPage: View {
    
    var body: some View {
        VStack(spacing:20) {
            Text("AR Space")
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text("Makerspace")
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            HStack(spacing:20) {
                NavigationLink(destination: ARMenuView()) {
                    Text("Gallery")
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
                NavigationLink(destination: ARGameMenuView()) {
                    Text("Game")
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
            Text("The Covid College Experience")
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            HStack(spacing:20) {
                NavigationLink(destination: ARPage()) {
                    Text("Coming Soon !")
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

struct ARPage_Previews: PreviewProvider {
    static var previews: some View {
        ARPage()
    }
}
