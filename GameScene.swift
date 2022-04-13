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
    var presentingBackground: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let node = createNode(for: stateMachine?.initialState)
        
        presentingBackground = node
    }
    
    func createNode(for state: StateMachineSymbol?) -> SKSpriteNode {
        guard let state = state else { return SKSpriteNode() }
        let node = SKSpriteNode()
        node.size = size
        var textures: [SKTexture] = []
        for i in (0..<state.frames) {
            textures.append(SKTexture(imageNamed: "\(state.sceneName)Frame\(i+1)"))
        }
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        let animationLoop = SKAction.repeatForever(animation)
        addChild(node)
        node.run(animationLoop)
        
        return node
    }
    
    func present(_ state: StateMachineSymbol?) {
        moveOutPresentingNode()
        moveInNewNode(of: state)
    }
    
    func moveOutPresentingNode() {
        let moveOut = SKAction.move(to: CGPoint(x: -0.5, y: 0.5), duration: 0.5)
        presentingBackground?.run(moveOut) {
            self.presentingBackground?.removeFromParent()
        }
    }
    
    func moveInNewNode(of state: StateMachineSymbol?) {
        let node = createNode(for: state)
        let moveIn = SKAction.move(to: CGPoint(x: 0.5, y: 0.5), duration: 0.5)
        node.run(moveIn) {
            self.presentingBackground? = node
        }
        
    }
}
