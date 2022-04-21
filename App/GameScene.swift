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
    
    let transitionInterval: TimeInterval = 0.5
    
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
        let moveOut = SKAction.move(to: CGPoint(x: -360, y: 0), duration: transitionInterval)
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
        let moveIn = SKAction.move(to: CGPoint(x: 0, y: 0), duration: transitionInterval)
        background.run(moveIn) {
            self.presentingBackground? = background
            
            guard let callback = callback else { return }
            callback()
        }
    }
    
    private func makeAnimation(for state: StateMachineSymbol) -> SKAction {
        var textures: [SKTexture] = []
        for i in (0..<state.numberOfFrames) {
            let texture = SKTexture(imageNamed: "\(state.sceneName)Frame\(i+1)")
            texture.filteringMode = .nearest
            textures.append(texture)
        }
        let animation = SKAction.animate(with: textures, timePerFrame: state.timePerFrame)
        return SKAction.repeatForever(animation)
    }
    
    private func updateAtomNode(by state: StateMachineSymbol?) {
        guard let state = state else { return }
        
        atomNode.removeAllActions()
        
        let move = SKAction.move(to: state.pixelPosition, duration: transitionInterval)
        let colorize = SKAction.colorize(with: state.pixelColor, colorBlendFactor: 1, duration: transitionInterval)
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
        case .swingWithColor:
            return swingAnimation()
        default:
            return nil
        }
    }
    
    private func floatingAnimation() -> SKAction {
        let transitionWait = SKAction.wait(forDuration: transitionInterval)
        
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 3), duration: 1)
        let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -3), duration: 1)
        let sequence = SKAction.sequence([moveUp, moveDown, moveDown, moveUp])
        let loop = SKAction.repeatForever(sequence)
        return SKAction.sequence([transitionWait, loop])
    }
    
    private func blueAndOrangeAnimation() -> SKAction {
        let transitionWait = SKAction.wait(forDuration: transitionInterval)
        
        let colorizeWhite = SKAction.colorize(with: .appWhite, colorBlendFactor: 1, duration: 0.4)
        let colorizeBlue = SKAction.colorize(with: .appBlue2, colorBlendFactor: 1, duration: 0.4)
        let colorizeOrange = SKAction.colorize(with: .appOrange1, colorBlendFactor: 1, duration: 0.4)
        let wait = SKAction.wait(forDuration: 0.3)
        let sequence = SKAction.sequence([colorizeBlue, wait, colorizeWhite, wait, colorizeOrange, colorizeWhite, wait])
        let loop = SKAction.repeatForever(sequence)
        return SKAction.sequence([transitionWait, loop])
    }
    
    private func swingAnimation() -> SKAction {
        let transitionWait = SKAction.wait(forDuration: transitionInterval)
        
        let colorizeWhite = SKAction.colorize(with: .appWhite, colorBlendFactor: 1, duration: 1)
        let colorizeBlue = SKAction.colorize(with: .appBlue2, colorBlendFactor: 1, duration: 1)
        let colorizeOrange = SKAction.colorize(with: .appOrange1, colorBlendFactor: 1, duration: 1)
        let wait = SKAction.wait(forDuration: 0.3)
        let colorSequence = SKAction.sequence([colorizeBlue, wait, colorizeWhite, colorizeOrange, wait, colorizeWhite])
        let colorLoop = SKAction.repeatForever(colorSequence)
        
        let moveLeft = SKAction.move(by: CGVector(dx: -80, dy: 0), duration: 1)
        let moveRight = SKAction.move(by: CGVector(dx: 80, dy: 0), duration: 1)
        let moveSequence = SKAction.sequence([moveRight, wait, moveLeft, moveLeft, wait, moveRight])
        let moveLoop = SKAction.repeatForever(moveSequence)
        
        let group = SKAction.group([colorLoop, moveLoop])
        
        return SKAction.sequence([transitionWait, group])
    }
}
