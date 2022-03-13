import Foundation
import UIKit
import RealityKit
import Combine

class ARMatchingGame : UIViewController {
    @IBOutlet var arView: ARView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var cancellable: AnyCancellable? = nil;
        let sphereAnchor = AnchorEntity(world: SIMD3(x:0, y:0, z:-50));
        cancellable = RealityKit.ModelEntity.loadModelAsync(named: "SkateboardMatching", in:nil).collect().sink(receiveCompletion: {error in print("Error: \(error)")
            print("Cancel")
            cancellable?.cancel()
            
        }, receiveValue: { entities in
            //var object : ModelEntity = entity
            print("entities ", entities)
            for entity in entities {
                entity.setScale(SIMD3<Float>(0.75,0.75,0.75), relativeTo: sphereAnchor)
                entity.generateCollisionShapes(recursive: true)
                sphereAnchor.addChild(entity);
            }
        })
        //print(arView.scene)
        //arView.scene.addAnchor(sphereAnchor);
    }
}
