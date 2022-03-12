//
//  marionView.swift
//  test
//
//  Created by Molly Brigham on 10/28/20.
// Modified by Nivedita Chellam on 03/01/22
//
//import SwiftUI
//
//struct marionView: View {
//    @State private var showDetails = false
//    var body: some View {
//        VStack {
//            Text("Dr. Marion Usselman on the Distance Math Program")
//                .font(.custom("Georgia", size: 30))
//                .fontWeight(.black)
//            Image("marion")
//                 .resizable()
//                 .aspectRatio(contentMode: .fit)
//            Text("Dr. Marion Usselman of the Center for Education Integrating Science, Mathematics, and Computing (CEISMC) talks about the origins of the Distance Math Program at Georgia Tech and her role as a pioneer in its creation and evolution.")
//                .font(.custom("Georgia", size: 13))
//                .foregroundColor(.secondary)
//                .font(.caption)
//
//            ZStack {
//                Capsule()
//                    .fill(Color.gray).frame(height: 8)
//                    .padding(10)
//                Capsule()
//                    .fill(Color.orange).frame(width: 12, height: 8)
//                    .padding(10)
//            }
//            Button(action: {
//                        self.showDetails.toggle()
//                        Sounds.playSounds(soundfile: "marionAudio.mp3")
//
//
//                        })
//
//            {
//                            Text("Play")
//
//                        }
//        }
//
//    }
//}
//
//struct marionView_Previews: PreviewProvider {
//    static var previews: some View {
//        marionView()
//    }
//}
import SwiftUI
import AVKit

struct marionView: View {
    var body: some View {
        marionPlayer()
    }
}

struct marionView_Previews: PreviewProvider {
    static var previews: some View {
        marionView()
    }
}

struct marionPlayer : View {
    @State var data : Data = .init(count: 0)
    @State var title = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var songs = ["marionAudio"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegateMarion()
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
                Text("Dr. Marion Usselman")
                    .font(.system(size: 32, weight: .medium, design: .serif))
                    .foregroundColor(.init(red: 0/255, green: 48/255, blue: 87/255))
                    .padding(.top)
                VStack(spacing: 10) {
                    Image(uiImage: self.data.count == 0 ? UIImage(named: "marion")! : UIImage(data: self.data)!)
                        .resizable()
                        .frame(width: self.data.count == 0 ? 150 : nil, height: 150)
                        .cornerRadius(15)
                        .padding()
                    Text("Dr. Marion Usselman of the Center for Education Integrating Science, Mathematics, and Computing (CEISMC) talks about the origins of the Distance Math Program at Georgia Tech and her role as a pioneer in its creation and evolution.")
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
                print(url)
                
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



class AVdelegateMarion : NSObject,AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
