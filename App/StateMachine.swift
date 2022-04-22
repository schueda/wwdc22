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
    let numberOfFrames: Int
    let timePerFrame: TimeInterval
    let pixelColor: UIColor
    let pixelPosition: CGPoint
    let pixelAction: PixelAction?
    
    internal init(phrase: String, options: [(text: String, state: StateMachineSymbol)], sceneName: String, numberOfFrames: Int, timePerFrame: TimeInterval, pixelColor: UIColor, pixelPosition: CGPoint, pixelAction: PixelAction? = nil) {
            self.phrase = phrase
            self.options = options
            self.sceneName = sceneName
            self.numberOfFrames = numberOfFrames
            self.timePerFrame = timePerFrame
            self.pixelColor = pixelColor
            self.pixelPosition = pixelPosition
            self.pixelAction = pixelAction
        }
}

class StateMachine {
    let initialState: StateMachineSymbol
    var currentState: StateMachineSymbol
    
    init() {
        let atom = StateMachineSymbol(phrase: "You're an atom.", options: [], sceneName: "atom", numberOfFrames: 30, timePerFrame: 0.1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 0), pixelAction: .floating)
        let partOfSomething = StateMachineSymbol(phrase: "That means you got to be part of something.", options: [], sceneName: "partOfSomething", numberOfFrames: 24, timePerFrame: 0.1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 4), pixelAction: .blueAndOrange)
        let alone = StateMachineSymbol(phrase: "There's so much you'll loose being alone.", options: [], sceneName: "answer", numberOfFrames: 1, timePerFrame: 0.1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 0), pixelAction: .floating)
        let aloneAnswer = StateMachineSymbol(phrase: "You wander around, meaningless...", options: [], sceneName: "answer", numberOfFrames: 1, timePerFrame: 0.1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 0), pixelAction: .wanderAnimation)
        let stardust = StateMachineSymbol(phrase: "What if you were stardust? or part of a burning big rock?", options: [], sceneName: "stardust", numberOfFrames: 19, timePerFrame: 0.1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 75), pixelAction: .swingWithColor)
        let arrival = StateMachineSymbol(phrase: "You've got on a planet on a beautiful night.", options: [], sceneName: "arrival", numberOfFrames: 11, timePerFrame: 0.1, pixelColor: .appBlack, pixelPosition: CGPoint(x: -125, y: -125))
        let meteor = StateMachineSymbol(phrase: "The universal laws eventually got you atracted to a bigger rock.", options: [], sceneName: "meteor", numberOfFrames: 27, timePerFrame: 0.1, pixelColor: .clear, pixelPosition: CGPoint(x: -300, y: 300))
        let dinosaur = StateMachineSymbol(phrase: "Some strange kind of life may have disappeared.", options: [], sceneName: "dinosaur", numberOfFrames: 3, timePerFrame: 1, pixelColor: .clear, pixelPosition: CGPoint(x: 0, y: 0))
        let rock = StateMachineSymbol(phrase: "You're part of a smaller fragment of what you used to be part of.", options: [], sceneName: "rock", numberOfFrames: 16, timePerFrame: 0.15, pixelColor: .appBlack, pixelPosition: CGPoint(x: 10, y: 20))
        let water = StateMachineSymbol(phrase: "You're part of the water.", options: [], sceneName: "Water", numberOfFrames: 3, timePerFrame: 0.1, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let bottle = StateMachineSymbol(phrase: "You're inside a bottle.", options: [], sceneName: "bottle", numberOfFrames: 1, timePerFrame: 0.1, pixelColor: .appBlue3, pixelPosition: CGPoint(x: 0, y: 0))
        let human = StateMachineSymbol(phrase: "You're part of a conscious being.", options: [], sceneName: "human", numberOfFrames: 3, timePerFrame: 0.1, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let dream = StateMachineSymbol(phrase: "", options: [], sceneName: "dream", numberOfFrames: 8, timePerFrame: 0.5, pixelColor: .appBlack, pixelPosition: CGPoint(x: 30, y: 0))
        let dreamAnswer = StateMachineSymbol(phrase: "Of course this means something. It means everything, and nothing. It means whatever you gave it a meaning. You mean whatever you give yourself a meaning.", options: [], sceneName: "answer", numberOfFrames: 9, timePerFrame: 0.1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 4))
        let nightmare = StateMachineSymbol(phrase: "You always thought you were unbreakable, but now you're part of the end.", options: [], sceneName: "nightmare", numberOfFrames: 3, timePerFrame: 0.1, pixelColor: .red, pixelPosition: CGPoint(x: 0, y: 0))
        let nightmareAnswer = StateMachineSymbol(phrase: "Every single thing in the universe is part of it. Beginnings are just a part of the end. Ends are just a part of the beginning.", options: [], sceneName: "answer", numberOfFrames: 9, timePerFrame: 0.1, pixelColor: .appWhite, pixelPosition: CGPoint(x: 0, y: 4))
        
        atom.options = [(text: "What does that mean?", state: partOfSomething)]
        partOfSomething.options = [(text: "Why?", state: alone), (text: "I've got to be part of something.", state: stardust)]
        alone.options = [(text: "Let me be alone.", state: aloneAnswer), (text: "I've got to be part of something.", state: stardust)]
        aloneAnswer.options = [(text: "...", state: atom)]
        stardust.options = [(text: "I'm stardust.", state: arrival), (text: "I'm part of a big rock.", state: meteor)]
        arrival.options = [(text: "Am I part of this world?", state: water)]
        meteor.options = [(text: "Has this hit?", state: dinosaur)]
        dinosaur.options = [(text: "I guess I'll miss them.", state: rock)]
        rock.options = [(text: "I'm just a rock on a river.", state: water)]
        water.options = [(text: "Am I the water itself?", state: bottle)]
        bottle.options = [(text: "I always thought i'd be part of something bigger.", state: human)]
        human.options = [(text: "Could I be part of a dream?", state: dream), (text: "Could I be part of a nightmare?", state: nightmare)]
        dream.options = [(text: "I hope this means something...", state: dreamAnswer)]
        dreamAnswer.options = [(text: "...", state: atom)]
        nightmare.options = [(text: "How come I be part of something so big?", state: nightmareAnswer)]
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
    case wanderAnimation
}

