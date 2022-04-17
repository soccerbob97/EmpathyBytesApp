//
//  interviewView.swift
//  test
//
//  Created by Molly Brigham on 10/28/20.
//
import SwiftUI
import UIKit

//this view represents the scroll page of interviews available to watch
struct interviewView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
       
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("EMPATHY BYTES")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Interviews")
                            .font(.custom("Georgia", size: 30))
                            .fontWeight(.black)
                    } //interview header
                    
                    Spacer()
                }
                .padding([.horizontal])
                //contains navigations to each interview, using cardview class that specifies the components of each card as image, date, title, and author
                ScrollView {
                    NavigationLink(destination: sheleahView()) {
                        cardView(image: "logoCircuitsTech", category: "Spring 2022", heading: "Sheleah Harris", author:"by Greyson Mullins")
                    }
                    NavigationLink(destination: samahView()) {
                        cardView(image: "logoCircuitsTech", category: "Spring 2022", heading: "Samah Khan", author:"by Greyson Mullins")
                    }
                    NavigationLink(destination: abiView()) {
                        cardView(image: "logoCircuitsTech", category: "Fall 2021", heading: "Abi Ivemeyer", author:"by Jocelyn Kavanagh")
                    }
                    NavigationLink(destination: joelView()) {
                        cardView(image: "logoCircuitsTech", category: "Fall 2021", heading: "Joel Jones", author:"by Jocelyn Kavanagh")
                    }
                    NavigationLink(destination: emaadView()) {
                        cardView(image: "logoCircuitsTech", category: "Fall 2021", heading: "Emaad Shamsi", author:"by Jocelyn Kavanagh")
                    }
                                        NavigationLink(destination: MusicView()) {
                        cardView(image: "invention", category: "April 30, 2020", heading: "Matthew Dick on being a Prototyping Instructor", author:"by Jaewon Drake")
                    }
                    NavigationLink(destination: georgiaView()) {
                        cardView(image: "ringgold", category: "February 27, 2020", heading: "Ringgold, Georgia: Lara Langston", author:"by Hunter Copp")
                    }
                    NavigationLink(destination: marionView()) {
                        cardView(image: "distmath", category: "November 29, 2019", heading: "Dr. Marion Usselman on the Distance Math Program", author:"by Jaewon Drake")
                    }
                    
 
            }
            
            
        
        
            }
    
}

struct interviewView_Previews: PreviewProvider {
    static var previews: some View {
        interviewView()
    }
}
}
