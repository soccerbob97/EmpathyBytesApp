import Foundation
import UIKit
import SwiftUI

struct ARModelView: UIViewControllerRepresentable {
    @Binding var modelTitle : String
    func updateUIViewController(_ uiViewController: ARModel, context: Context) {

    }
    

    func makeUIViewController(context: Context) -> ARModel {
        print("in view controller arMenuView")
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ARModel")
                as ARModel;
        // create viewController for ARMenu that uses the ARViewStoryboard
        viewController.modelTitle = modelTitle
        return viewController
    }

    func updateUIViewController(context: Context) {

        // update code

    }

}
