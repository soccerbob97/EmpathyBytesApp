import Foundation
import UIKit
import SwiftUI

struct ARMatchGameModelView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: ARMatchGameModel, context: Context) {

    }
    

    func makeUIViewController(context: Context) -> ARMatchGameModel {
        let viewController = UIStoryboard(name: "MatchGameSt", bundle: nil).instantiateViewController(identifier: "ARMatchGameModel")
                as ARMatchGameModel;
        // create viewController for ARMenu that uses the ARViewStoryboard
        return viewController
    }

    func updateUIViewController(context: Context) {

        // update code

    }

}
