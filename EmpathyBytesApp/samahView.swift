//
//  samahView.swift
//  EmpathyBytesApp
//
//  Created by Nivedita Chellam on 4/11/22.
//

import SwiftUI
import AVKit

struct samahView: View {
    var body: some View {
        samahPlayer()
    }
}

struct samahView_Previews: PreviewProvider {
    static var previews: some View {
        samahView()
    }
}

struct samahPlayer : View {
    @State var data : Data = .init(count: 0)
    @State var title = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var songs = ["placeholder"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegateSamah()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body : some View{
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.init(red: 1.0, green: 1.0, blue: 223/255), .init(red: 178/255, green: 241/255, blue: 242/255)]), startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        
            Text("")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
                    self.player.pause()
                    self.playing = false
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "arrow.left")
                })
            VStack(spacing: 40) { // Information stack
                Text("Samah Khan")
                    .font(.system(size: 32, weight: .medium, design: .serif))
                    .foregroundColor(.init(red: 0/255, green: 48/255, blue: 87/255))
                    .padding(.top)
                VStack(spacing: 10) {
                    Image(uiImage: self.data.count == 0 ? UIImage(named: "logoCircuitsTech")! : UIImage(data: self.data)!)
                        .resizable()
                        .frame(width: self.data.count == 0 ? 150 : nil, height: 150)
                        .cornerRadius(15)
                        .padding()
                    Text("Samah Khan started her undergraduate studies in her childhood bedroom.  Khan was originally on track and excited to attend the University of Georgia in Athens.  However, when she learned she would be forced to live in the dorms despite health and safety concerns, she decided it would be best for her to continue to attend Georgia State University, where she had dual-enrolled in high school.  Like many first-year students, Khan felt deeply disconnected from the campus community at Georgia State when attending courses online.  Unfortunately, when the Fall 2021 semester, came and Khan attended courses in person, she still was not convinced that Georgia State was the right fit for her.  Khan describes her mother pushing her to pursue a degree from Georgia Tech, as many of their close friends graduated from Georgia Tech.  She describes submitting her transfer application partially to appease her mother, but when she received her acceptance letter, she decided Georgia Tech was going to become her new place of study.  We spoke to Khan in early February, and she had loved her first month at Georgia Tech.  To hear more about Khan’s journey to Georgia Tech and experience beginning college from her childhood bedroom, check back to find her video interview.")
                        .font(.system(size: 13, weight: .medium, design: .serif))
                        .foregroundColor(.init(red: 0/255, green: 48/255, blue: 87/255))
                        .padding()
                    Text(self.title).font(.title).padding(.top)
    //
                        ZStack(alignment: .leading) {
                        
                            Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                            
                            Capsule().fill(Color.init(red: 0/255, green: 48/255, blue: 87/255)).frame(width: self.width, height: 8)
                            .gesture(DragGesture()
                                .onChanged({ (value) in
                                    
                                    let x = value.location.x
                                    
                                    self.width = x
                                    
                                }).onEnded({ (value) in
                                    
                                    let x = value.location.x
                                    
                                    let screen = UIScreen.main.bounds.width - 30
                                    
                                    let percent = x / screen
                                    
                                    self.player.currentTime = Double(percent) * self.player.duration
                                }))
                        }
                        .padding(.top)
                
                HStack(spacing: UIScreen.main.bounds.width / 5 - 30){
                    
                    
                        Button(action: { //this button goes back 15 seconds in the audio
                            
                            self.player.currentTime -= 15
                            
                        }) {
                    
                            Image(systemName: "gobackward.15").font(.title)
                            
                        }
                    
                        Button(action: { //this button pauses and unpauses the audio
                            
                            if self.player.isPlaying{
                                
                                self.player.pause()
                                self.playing = false
                            }
                            else{
                                
                                if self.finish{
                                    
                                    self.player.currentTime = 0
                                    self.width = 0
                                    self.finish = false
                                    
                                }
                                
                                self.player.play()
                                self.playing = true
                            }
                            
                        }) {
                    
                            Image(systemName: self.playing && !self.finish ? "pause.fill" : "play.fill").font(.title)
                            
                        }
                    
                        Button(action: { //this button increments the time by 15 seconds
                           
                            let increase = self.player.currentTime + 15
                            
                            if increase < self.player.duration{
                                
                                self.player.currentTime = increase
                            }
                            
                        }) {
                    
                            Image(systemName: "goforward.15").font(.title)
                            
                        }
                    
                }.padding(.top,25)
                .foregroundColor(.black)
                
            }.padding()
            .onAppear {
                
                let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
                
                self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                
                self.player.delegate = self.del
                
                self.player.prepareToPlay()
                self.getData()
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    
                    if self.player.isPlaying{
                        
                        let screen = UIScreen.main.bounds.width - 30
                        
                        let value = self.player.currentTime / self.player.duration
                        
                        self.width = screen * CGFloat(value)
                    }
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                    
                    self.finish = true
                }
            }
            
            }
                }

                
    }
    
    
    func getData(){
        
        
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata{
            
            if i.commonKey?.rawValue == "artwork"{
                
                let data = i.value as! Data
                self.data = data
            }
            
            if i.commonKey?.rawValue == "title"{
                
                let title = i.value as! String
                self.title = title
            }
        }
    }
    
}

class AVdelegateSamah : NSObject,AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
