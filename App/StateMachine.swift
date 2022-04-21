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
        let partOfSomething = StateMachineSymbol(phrase: "That means you got to be part of something.", options: [], sceneName: "partOfSomething", frames: 24, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 4), pixelAction: .blueAndOrange)
        let alone = StateMachineSymbol(phrase: "There's so much you'll loose being alone.", options: [], sceneName: "alone", frames: 1, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let aloneAnswer = StateMachineSymbol(phrase: "You wander around, meaningless...", options: [], sceneName: "aloneAnswer", frames: 1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 0))
        let stardust = StateMachineSymbol(phrase: "What if you were stardust? or part of a floating big rock?", options: [], sceneName: "stardust", frames: 19, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 75), pixelAction: .swingWithColor)
        let arrival = StateMachineSymbol(phrase: "You've got on a planet on a beautiful night.", options: [], sceneName: "arrival", frames: 11, pixelColor: .appBlack, pixelPosition: CGPoint(x: -125, y: -125))
        let meteor = StateMachineSymbol(phrase: "The universal laws eventually got you atracted to a bigger rock.", options: [], sceneName: "meteor", frames: 27, pixelColor: .appWhite, pixelPosition: CGPoint(x: -300, y: 300))
        let dinossaur = StateMachineSymbol(phrase: "Some strange kind of life may have disappeared.", options: [], sceneName: "dinossaur", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let rock = StateMachineSymbol(phrase: "You're part of a smaller fragment of what you used to be part of.", options: [], sceneName: "rock", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let water = StateMachineSymbol(phrase: "You're part of the water.", options: [], sceneName: "Water", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let bottle = StateMachineSymbol(phrase: "You're inside a bottle.", options: [], sceneName: "bottle", frames: 1, pixelColor: .appBlue3, pixelPosition: CGPoint(x: 0, y: 0))
        let human = StateMachineSymbol(phrase: "You're part of a conscious been.", options: [], sceneName: "human", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let dream = StateMachineSymbol(phrase: "", options: [], sceneName: "dream", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let dreamAnswer = StateMachineSymbol(phrase: "Of course this means something. It means everything, and nothing. It means whatever you gave it a meaning. And it always have been like this. Every single thing you've been part of, means what you gave it a meaning. And it will always be like this, everything is constantly changing and eventually could come to mean nothing.", options: [], sceneName: "dreamAnswer", frames: 1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 0))
        let nightmare = StateMachineSymbol(phrase: "You always thought you were unbreakable, but now you're part of the end.", options: [], sceneName: "nightmare", frames: 3, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let nightmareAnswer = StateMachineSymbol(phrase: "Every single thing in the universe is part of it. Beginnings are just a part of the end. Ends are just a part of the beginning.", options: [], sceneName: "nightmareAnswer", frames: 1, pixelColor: .appOrange3, pixelPosition: CGPoint(x: 0, y: 0))
        
        atom.options = [(text: "What does that mean?", state: partOfSomething)]
        partOfSomething.options = [(text: "Why?", state: alone), (text: "I've got to be part of something.", state: stardust)]
        alone.options = [(text: "Let me be alone.", state: aloneAnswer), (text: "I've got to be part of something.", state: stardust)]
        aloneAnswer.options = [(text: "...", state: atom)]
        stardust.options = [(text: "I am stardust", state: arrival), (text: "I'm part of a big rock", state: meteor)]
        arrival.options = [(text: "Am I part of this world?", state: water)]
        meteor.options = [(text: "Has this hit?", state: dinossaur)]
        dinossaur.options = [(text: "I guess I'll miss them.", state: rock)]
        rock.options = [(text: "I'm just a rock on the riverside.", state: water)]
        water.options = [(text: "Am I the water itself?", state: bottle)]
        bottle.options = [(text: "I always thought i'd be part of something bigger.", state: human)]
        human.options = [(text: "Could I be part of a dream?", state: dream), (text: "Could I be part of a nightmare?", state: nightmare)]
        dream.options = [(text: "I hope this means something...", state: dreamAnswer)]
        dreamAnswer.options = [(text: "...", state: atom)]
        nightmare.options = [(text: "How come I be part of something so big?", state: atom)]
        nightmareAnswer.options = [(text: "...", state: atom)]
        
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
    case swingWithColor
}

