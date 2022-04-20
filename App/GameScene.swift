//
//  File.swift
//  wwdc22
//
//  Created by André Schueda on 12/04/22.
//

import Foundation
import SpriteKit
import UIKit

class GameScene: SKScene {
    var stateMachine: StateMachine?
    var presentingBackground: SKSpriteNode?
    
    lazy var atomNode: SKSpriteNode = {
        let node = SKSpriteNode()
        node.size = CGSize(width: 20, height: 20)
        node.position = CGPoint(x: 0, y: 0)
        node.zPosition = 1000
        node.color = UIColor(named: "appBlue1")!
        return node
    }()
    
    override func didMove(to view: SKView) {
        addChild(atomNode)
        presentingBackground = initialPresent(stateMachine?.initialState)
    }
    
    private func initialPresent(_ state: StateMachineSymbol?) -> SKSpriteNode {
        let newNode = createNode(for: stateMachine?.currentState)
        newNode.position = CGPoint(x: 0, y: 0)
        updateAtomNode(by: state)
        
        return newNode
    }
    
    func present(_ state: StateMachineSymbol?, callback: (()->())? = nil) {
        moveOutPresentingBackground()
        let newNode = createNode(for: stateMachine?.currentState)
        moveIn(background: newNode) {
            guard let callback = callback else { return }
            callback()
        }
        
        updateAtomNode(by: state)
    }
    
    private func moveOutPresentingBackground() {
        let moveOut = SKAction.move(to: CGPoint(x: -360, y: 0), duration: 0.5)
        presentingBackground?.run(moveOut) {
            self.presentingBackground?.removeFromParent()
        }
    }
    
    private func createNode(for state: StateMachineSymbol?) -> SKSpriteNode {
        guard let state = state else { return SKSpriteNode() }
        let node = SKSpriteNode()
        node.position = CGPoint(x: 360, y: 0)
        node.size = SKTexture(imageNamed: "\(state.sceneName)Frame1").size()
        
        
        addChild(node)
        node.run(makeAnimation(for: state))
        
        return node
    }
    
    private func moveIn(background: SKSpriteNode, callback: (()->())? = nil) {
        let moveIn = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.5)
        background.run(moveIn) {
            self.presentingBackground? = background
            
            guard let callback = callback else { return }
            callback()
        }
    }
    
    private func makeAnimation(for state: StateMachineSymbol) -> SKAction {
        var textures: [SKTexture] = []
        for i in (0..<state.frames) {
            let texture = SKTexture(imageNamed: "\(state.sceneName)Frame\(i+1)")
            texture.filteringMode = .nearest
            textures.append(texture)
        }
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        return SKAction.repeatForever(animation)
    }
    
    private func updateAtomNode(by state: StateMachineSymbol?) {
        guard let state = state else { return }
        
        atomNode.removeAllActions()
        
        let move = SKAction.move(to: state.pixelPosition, duration: 0.5)
        let colorize = SKAction.colorize(with: state.pixelColor, colorBlendFactor: 1, duration: 0.5)
        let group = SKAction.group([move, colorize])
        atomNode.run(group)
        
        guard let action = getPixelAction(for: state) else { return }
        atomNode.run(action)
    }
    
    private func getPixelAction(for state: StateMachineSymbol) -> SKAction? {
        switch state.pixelAction {
        case .floating:
            return floatingAnimation()
        case .blueAndOrange:
            return blueAndOrangeAnimation()
        default:
            return nil
        }
    }
    
    private func floatingAnimation() -> SKAction {
        let moveTop = SKAction.move(by: CGVector(dx: 0, dy: 5), duration: 1.5)
        let moveBottom = SKAction.move(by: CGVector(dx: 0, dy: -5), duration: 1.5)
        let sequence = SKAction.sequence([moveTop, moveBottom])
        return SKAction.repeatForever(sequence)
    }
    
    private func blueAndOrangeAnimation() -> SKAction {
        let colorizeWhite = SKAction.colorize(with: .appWhite, colorBlendFactor: 1, duration: 0.4)
        let colorizeBlue = SKAction.colorize(with: .appBlue2, colorBlendFactor: 1, duration: 0.4)
        let colorizeOrange = SKAction.colorize(with: .appOrange1, colorBlendFactor: 1, duration: 0.4)
        let wait = SKAction.wait(forDuration: 0.3)
        let sequence = SKAction.sequence([colorizeBlue, wait, colorizeWhite, wait, colorizeOrange, colorizeWhite, wait])
        return SKAction.repeatForever(sequence)
    }
}
