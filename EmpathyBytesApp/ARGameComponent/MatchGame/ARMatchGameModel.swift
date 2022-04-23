//
//  ARModel.swift
//  EmpathyBytesApp
//
//  Created by Harsha Karanth on 11/8/21.
//

import Foundation
import UIKit
import RealityKit
import Combine


class ARMatchGameModel: UIViewController {
    @IBOutlet var arView: ARView!
    
    //var gameObjects : [ARGameObject] = []
    var gameObjects : [RealityKit.ModelEntity] = []
    var arObjects : [MatchingGameObject] = []
    var objectFound : [String] = []
    var anchor: AnchorEntity = AnchorEntity(plane: .horizontal,minimumBounds: [0.2,0.2])
    var cards: [Entity] = []
    var numOfGuesses : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    
        arView.scene.addAnchor(anchor)
        
        for _ in 1...16 {
            let box = MeshResource.generateBox(width: 0.04, height: 0.002, depth: 0.04)
            let metalMaterial = SimpleMaterial(color:.gray,
                                               isMetallic:true)
            let model = RealityKit.ModelEntity(mesh:box,materials:[metalMaterial])
            model.generateCollisionShapes(recursive:true)
            cards.append(model)
        }
        for (index,card) in cards.enumerated() {
            let x = Float(index % 4)
            let z = Float(index / 4)
            card.position = [x * 0.1,0,z * 0.1]
            anchor.addChild(card)
        }
        let boxSize: Float = 0.7
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        let occlusionBox = RealityKit.ModelEntity(mesh:occlusionBoxMesh,
                                       materials:[OcclusionMaterial()])
        occlusionBox.position.y = -boxSize/2
        anchor.addChild(occlusionBox)
        self.loadWoodenTable()

        
    
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in:arView)
        if let card = arView.entity(at:tapLocation) {
            var parentObj = card
            if card.children.count == 0 {
                parentObj = card.parent!
            }
            var alreadyFound : Bool = false
            for objectStr in self.objectFound {
                if objectStr == parentObj.name {
                    alreadyFound = true
                }
            }
            
            if parentObj.transform.rotation.angle == .pi && !alreadyFound{
                var flipUpTransform = parentObj.transform
                flipUpTransform.rotation = simd_quatf(angle:0,axis:[1,0,0])
                parentObj.move(to:flipUpTransform,relativeTo: parentObj.parent,duration: 0.25,
                              timingFunction: .easeInOut)
                var matchStreak : Int = 1
                numOfGuesses += 1
                for i in stride(from:0, to:cards.count, by:1) {
                    if cards[i] != parentObj && cards[i].transform.rotation.angle < 1 {
                        var shouldContinue : Bool = false
                        for foundName in objectFound {
                            if cards[i].name == foundName {
                                shouldContinue = true
                            }
                        }
                        if shouldContinue {
                            continue
                        }
                        if parentObj.name != cards[i].name {
                            var flipDownTransform = cards[i].transform
                            flipDownTransform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
                            cards[i].move(to: flipDownTransform, relativeTo: cards[i].parent, duration: 0.25, timingFunction: .easeInOut)
                        } else {
                            matchStreak += 1
                            if matchStreak == 4 {
                                objectFound.append(parentObj.name)
                                matchStreak = 0
                            }
                            if objectFound.count == 4 {
                                let gameWonStr = "You win! You took " + String(numOfGuesses) + " tries"
                                let alertController = UIAlertController(title: gameWonStr, message: "", preferredStyle: UIAlertController.Style.alert)
                                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
                                present(alertController,animated: true,completion: nil)
                            }
                        }
                    }
                }
            } else if(!alreadyFound) {
                var flipDownTransform = parentObj.transform
                flipDownTransform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
                parentObj.move(to: flipDownTransform, relativeTo: parentObj.parent, duration: 0.25, timingFunction: .easeInOut)
            }
        }
    }
    
    
    func loadWoodenTable() {
        var cancellable: AnyCancellable? = nil;
        cancellable = RealityKit.ModelEntity.loadModelAsync(named: "WoodenTableGame", in:nil)
            .collect().sink(receiveCompletion: {error in print("Error: \(error)")
            cancellable?.cancel()
        }, receiveValue: { entities in
            
            for entity in entities {
                
                entity.setScale(SIMD3<Float>(0.00015,0.00015,0.00015), relativeTo: self.anchor)
                entity.generateCollisionShapes(recursive: true)
                for _ in 1...4 {
                    let entityClone = entity.clone(recursive:true)
                    entityClone.name = "WoodenTable"
                    self.gameObjects.append(entityClone)
                }
            }
            self.loadToyAirplane()
        });
    }
    
    func loadToyAirplane() {
        var cancellable: AnyCancellable? = nil;
        cancellable = RealityKit.ModelEntity.loadModelAsync(named: "ToyAirplaneGame", in:nil)
            .collect().sink(receiveCompletion: {error in print("Error: \(error)")
            cancellable?.cancel()
        }, receiveValue: { entities in
            
            for entity in entities {
                
                entity.setScale(SIMD3<Float>(0.002,0.002,0.002), relativeTo: self.anchor)
                entity.generateCollisionShapes(recursive: true)
                for _ in 1...4 {
                    let entityClone = entity.clone(recursive:true)
                    entityClone.name = "ToyAirplane"
                    self.gameObjects.append(entityClone)
                }
            }
            self.loadFlowerPot()
            //self.attachObjects()
        });
    }
    
    func loadFlowerPot() {
        var cancellable: AnyCancellable? = nil;
        cancellable = RealityKit.ModelEntity.loadModelAsync(named: "FlowerPotGame", in:nil)
            .collect().sink(receiveCompletion: {error in print("Error: \(error)")
            cancellable?.cancel()
        }, receiveValue: { entities in
            
            for entity in entities {
                
                entity.setScale(SIMD3<Float>(0.0008,0.0008,0.0008), relativeTo: self.anchor)
                entity.generateCollisionShapes(recursive: true)
                for _ in 1...4 {
                    let entityClone = entity.clone(recursive:true)
                    entityClone.name = "FlowerPot"
                    self.gameObjects.append(entityClone)
                }
            }
            
            self.loadStudioStand()
            //self.attachObjects()
        });
    }
    
    func loadStudioStand() {
        var cancellable: AnyCancellable? = nil;
        cancellable = RealityKit.ModelEntity.loadModelAsync(named: "StudioStandGame", in:nil)
            .collect().sink(receiveCompletion: {error in print("Error: \(error)")
            cancellable?.cancel()
        }, receiveValue: { entities in
            
            for entity in entities {
                
                entity.setScale(SIMD3<Float>(0.0002,0.0002,0.0002), relativeTo: self.anchor)
                entity.generateCollisionShapes(recursive: true)
                for _ in 1...4 {
                    let entityClone = entity.clone(recursive:true)
                    entityClone.name = "StudioStand"
                    self.gameObjects.append(entityClone)
                }
            }
            self.attachObjects()
        });
    }
    
    func attachObjects() {
        self.gameObjects.shuffle()
        for (index,object) in self.gameObjects.enumerated() {
            cards[index].addChild(object)
            cards[index].name = object.name
            cards[index].transform.rotation = simd_quatf(angle:.pi,axis:[1,0,0])
        }
    }
}
