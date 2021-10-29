//
//  ARMenuView.swift
//  empathyApp
//
//  Created by Harsha Karanth on 10/21/21.
//

import Foundation
import UIKit
import SwiftUI

struct ARMenuView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: ARMenu, context: Context) {

    }
    

    func makeUIViewController(context: Context) -> ARMenu {
        print("in view controller arMenuView")
        let viewController = UIStoryboard(name: "ARViewStoryboard", bundle: nil).instantiateViewController(identifier: "ARMenu")
                as ARMenu;
        // create viewController for ARMenu that uses the ARViewStoryboard

        return viewController
    }

    func updateUIViewController(context: Context) {

        // update code

    }

}
