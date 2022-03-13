//
//  ARGameMenuView.swift
//  EmpathyBytesApp
//
//  Created by Harsha Karanth on 3/10/22.
//

import Foundation
import UIKit
import SwiftUI

struct ARGameMenuView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: ARMatchingGame, context: Context) {

    }
    

    func makeUIViewController(context: Context) -> ARMatchingGame {
        print("in view controller Game Menu view")
        let viewController = UIStoryboard(name: "GameMenuStoryboard", bundle: nil).instantiateViewController(identifier: "ARMatchingGame")
                as ARMatchingGame;
        // create viewController for ARMenu that uses the ARViewStoryboard
        return viewController
    }

    func updateUIViewController(context: Context) {

        // update code

    }

}
