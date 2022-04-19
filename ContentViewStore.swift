//
//  ContentViewStore.swift
//  wwdc22
//
//  Created by André Schueda on 13/04/22.
//

import Foundation
import CoreGraphics

class ContentViewStore: ObservableObject {
    
    var stateMachine = StateMachine()
    lazy var scene: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: 360, height: 640)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFill
        
        return scene
    }()
    
}
