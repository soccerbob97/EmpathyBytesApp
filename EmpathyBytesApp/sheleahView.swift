//
//  sheleahView.swift
//  EmpathyBytesApp
//
//  Created by Nivedita Chellam on 4/11/22.
//

import SwiftUI
import AVKit

struct sheleahView: View {
    var body: some View {
        sheleahPlayer()
    }
}

struct sheleahView_Previews: PreviewProvider {
    static var previews: some View {
        sheleahView()
    }
}

struct sheleahPlayer : View {
    @State var data : Data = .init(count: 0)
    @State var title = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var songs = ["placeholder"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegateSheleah()
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
                Text("Sheleah Harris")
                    .font(.system(size: 32, weight: .medium, design: .serif))
                    .foregroundColor(.init(red: 0/255, green: 48/255, blue: 87/255))
                    .padding(.top)
                VStack(spacing: 10) {
                    Image(uiImage: self.data.count == 0 ? UIImage(named: "logoCircuitsTech")! : UIImage(data: self.data)!)
                        .resizable()
                        .frame(width: self.data.count == 0 ? 150 : nil, height: 150)
                        .cornerRadius(15)
                        .padding()
                    Text("The COVID-19 Pandemic changed the way we all interact with the world, but for Second-Year Student and Track Athlete, Sheleah Harris, college was going to look very different from what she imagined.  Harris grew up in Athens and chose to forego an education at the University of Georgia to attend Georgia Tech in pursuit of a bachelor's degree in Computational Media (abbreviated as CM).  The CM program is not offered at very many universities in the United States, and Georgia Tech is the only school in the state to offer such a degree.  For Harris, the choice was straightforward, Georgia Tech offered an excellent education in any field, and Computational Media is no exception.  With that said, the journey through Tech presented Harris with challenges personally, academically, and athletically.  Harris’ first year of collegiate track competition was anything, but normal.  She describes her experiences at meets where athletes remained separated from each other, masked, and constantly waiting to receive negative COVID tests.  The entire experience feels incredibly surreal, and one can only imagine how deeply this affected athletes' mental game.  Harris describes a particularly, heartbreaking experience in which she was about to compete in the indoor ACC Championships, and received notice that she had been contact traced and had to return home for the health and safety of all athletes, coaches, and event staff.  The video interview with Harris is still underwork but check back to hear more about her experiences as a college athlete in the midst of a global pandemic.")
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

class AVdelegateSheleah : NSObject,AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
