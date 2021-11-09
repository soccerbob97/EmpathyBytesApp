//
//  ModelDescriptionView.swift
//  EmpathyBytesApp
//
//  Created by Harsha Karanth on 11/8/21.
//

import SwiftUI

struct ModelDescriptionView: View {
    var modelEntity: ModelEntity
    var body: some View {
        VStack(spacing:20) {
            Image(modelEntity.imageName)
                .resizable()
                .scaledToFit()
                .frame(height:200)
                .cornerRadius(12)
            Text(modelEntity.title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text(modelEntity.description)
                .font(.body)
                .padding()
            Spacer()
            NavigationLink(destination: ARModelView()) {
                Text("See Model!")
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
    }
}

struct ModelDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ModelDescriptionView(modelEntity: ModelEntity(imageName: ImageConstants.toyAirplane,
                                                      title: ImageConstants.toyAirplaneTitle,
                                                      description: ImageConstants.toyAirplaneDescription))
    }
}
