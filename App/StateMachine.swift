//
//  StateMachine.swift
//  wwdc22
//
//  Created by André Schueda on 12/04/22.
//

import Foundation
import UIKit
import SpriteKit

class StateMachineSymbol {
    let phrase: String
    var options: [(text: String, state: StateMachineSymbol)]
    let sceneName: String
    let frames: Int
    let pixelColor: UIColor
    let pixelPosition: CGPoint
    let pixelAction: PixelAction?
    
    internal init(phrase: String, options: [(text: String, state: StateMachineSymbol)], sceneName: String, frames: Int, pixelColor: UIColor, pixelPosition: CGPoint, pixelAction: PixelAction? = nil) {
            self.phrase = phrase
            self.options = options
            self.sceneName = sceneName
            self.frames = frames
            self.pixelColor = pixelColor
            self.pixelPosition = pixelPosition
            self.pixelAction = pixelAction
        }
}

class StateMachine {
    let initialState: StateMachineSymbol
    var currentState: StateMachineSymbol
    
    init() {
        let atom = StateMachineSymbol(phrase: "You're an atom.", options: [], sceneName: "atom", frames: 30, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 0), pixelAction: .floating)
        let partOfSomething = StateMachineSymbol(phrase: "That means you got to be part of something.", options: [], sceneName: "partOfSomething", frames: 24, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 3.2), pixelAction: .blueAndOrange)
        let alone = StateMachineSymbol(phrase: "There's so much you'll loose being alone.", options: [], sceneName: "alone", frames: 1, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let stardust = StateMachineSymbol(phrase: "What if you were stardust? or part of a floating big rock?", options: [], sceneName: "stardust", frames: 19, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let arrival = StateMachineSymbol(phrase: "You've got on a planet on a beautiful night.", options: [], sceneName: "arrival", frames: 11, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let meteor = StateMachineSymbol(phrase: "The universal laws eventually got you atracted to a bigger rock.", options: [], sceneName: "meteor", frames: 27, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let dinossaur = StateMachineSymbol(phrase: "Some strange kind of life may have disappeared.", options: [], sceneName: "dinossaur", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let rock = StateMachineSymbol(phrase: "You're part of a smaller fragment of what you used to be part of.", options: [], sceneName: "rock", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let water = StateMachineSymbol(phrase: "You're part of the water.", options: [], sceneName: "Water", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let bottle = StateMachineSymbol(phrase: "You're inside a bottle.", options: [], sceneName: "bottle", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let human = StateMachineSymbol(phrase: "You're part of a conscious been.", options: [], sceneName: "human", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let dream = StateMachineSymbol(phrase: "", options: [], sceneName: "dream", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let nightmare = StateMachineSymbol(phrase: "You always thought you were unbreakable, but now you're part of the end.", options: [], sceneName: "nightmare", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        
        atom.options = [(text: "What does that mean?", state: partOfSomething)]
        partOfSomething.options = [(text: "Why?", state: alone), (text: "I've got to be part of something.", state: stardust)]
        alone.options = [(text: "Let me be alone.", state: atom), (text: "I've got to be part of something.", state: stardust)]
        stardust.options = [(text: "I am stardust", state: arrival), (text: "I'm part of a big rock", state: meteor)]
        arrival.options = [(text: "Am I part of this world?", state: water)]
        meteor.options = [(text: "Has this hit?", state: dinossaur)]
        dinossaur.options = [(text: "I guess I'll miss them.", state: rock)]
        rock.options = [(text: "I'm just a rock on the riverside.", state: water)]
        water.options = [(text: "Am I the water itself?", state: bottle)]
        bottle.options = [(text: "I always thought i'd be part of something bigger.", state: human)]
        human.options = [(text: "Could I be part of beautiful dreams?", state: dream), (text: "Could I be part of nasty nightmares?", state: nightmare)]
        dream.options = [(text: "I hope this means something...", state: human)]
        nightmare.options = [(text: "How come I be part of something so big?", state: atom)]
        
        initialState = atom
        currentState = initialState
    }
    
    func transition(to option: Int) -> StateMachineSymbol {
        currentState = currentState.options[option].state
        return currentState
    }
}

enum PixelAction {
    case floating
    case blueAndOrange
}
