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
    
    var showingNode: SKSpriteNode?
    var outsideNode: SKSpriteNode?
    
    lazy var backgroundNode1: SKSpriteNode = {
        let node = SKSpriteNode()
        node.color = .systemRed
        node.size = size
        node.position = CGPoint(x: 0.5, y: 0.5)
        return node
    }()
    
    lazy var backgroundNode2: SKSpriteNode = {
        let node = SKSpriteNode()
        node.color = .systemBlue
        node.size = size
        node.position = CGPoint(x: 1.5, y: 0.5)
        return node
    }()
    
    override func didMove(to view: SKView) {
        addChild(backgroundNode1)
        addChild(backgroundNode2)
        showingNode = backgroundNode1
        outsideNode = backgroundNode2
        
        
        let initialState = stateMachine?.initialState
        present(initialState)
    }
    
    func present(_ state: StateMachineSymbol?) {
        let moveIn = SKAction.move(to: CGPoint(x: 0.5, y: 0.5), duration: 0.5)
        let moveOut = SKAction.move(to: CGPoint(x: -0.5, y: 0.5), duration: 0.5)
        
        showingNode?.run(moveOut)
        outsideNode?.run(moveIn)
        
        showingNode = showingNode == backgroundNode1 ? backgroundNode2 : backgroundNode1
        outsideNode = outsideNode == backgroundNode1 ? backgroundNode2 : backgroundNode1
    }
}
