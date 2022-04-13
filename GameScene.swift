//
//  File.swift
//  wwdc22
//
//  Created by André Schueda on 12/04/22.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    var stateMachine: StateMachine?
    
    override func didMove(to view: SKView) {
        
        let initialState = stateMachine?.initialState
        present(initialState)
    }
    
    func present(_ state: StateMachineSymbol?) {
        
    }
}
