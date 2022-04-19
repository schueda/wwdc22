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
        node.position = CGPoint(x: 0.5, y: 0.5)
        presentingBackground = node
    }
    
    func createNode(for state: StateMachineSymbol?) -> SKSpriteNode {
        guard let state = state else { return SKSpriteNode() }
        let node = SKSpriteNode()
        node.position = CGPoint(x: 360, y: 0)
        node.size = SKTexture(imageNamed: "\(state.sceneName)Frame1").size()
        
        
        addChild(node)
        node.run(makeAnimation(for: state))
        
        return node
    }
    
    func makeAnimation(for state: StateMachineSymbol) -> SKAction {
        var textures: [SKTexture] = []
        for i in (0..<state.frames) {
            let texture = SKTexture(imageNamed: "\(state.sceneName)Frame\(i+1)")
            texture.filteringMode = .nearest
            textures.append(texture)
        }
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        return SKAction.repeatForever(animation)
    }
    
    func present(_ state: StateMachineSymbol?, callback: (()->())?) {
        moveOutPresentingNode()
        let newNode = createNode(for: stateMachine?.currentState)
        moveIn(node: newNode) {
            guard let callback = callback else { return }
            callback()            
        }
        
    }
    
    func moveOutPresentingNode() {
        let moveOut = SKAction.move(to: CGPoint(x: -360, y: 0), duration: 0.5)
        presentingBackground?.run(moveOut) {
            self.presentingBackground?.removeFromParent()
        }
    }
    
    func moveIn(node: SKSpriteNode, callback: (()->())!) {
        let moveIn = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.5)
        node.run(moveIn) {
            self.presentingBackground? = node
            callback()
        }
    }
}
