//
//  ParticlesViewModel.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/5/28.
//

import Foundation
import SpriteKit

class Floating: SKScene {
    var birthRate: CGFloat = 0.0;
    var node = SKEmitterNode(fileNamed: "Floating.sks")!
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 0)
        // bg color
        backgroundColor = .clear
        
        // creating node and adding to scene
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        node.particleBirthRate = birthRate
    }
}

class BirthdayCakeRain: SKScene {
    var birthRate: CGFloat = 0.0;
    var node = SKEmitterNode(fileNamed: "BirthdayCake.sks")!
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 1)
        // bg color
        backgroundColor = .clear
        
        // creating node and adding to scene
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        node.particleBirthRate = birthRate
    }
}

class PartyingRain: SKScene {
    var birthRate: CGFloat = 0.0;
    var node = SKEmitterNode(fileNamed: "Partying.sks")!
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 1)
        // bg color
        backgroundColor = .clear
        
        // creating node and adding to scene
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        node.particleBirthRate = birthRate
    }
}

class SmilingHeartRain: SKScene {
    var birthRate: CGFloat = 0.0;
    var node = SKEmitterNode(fileNamed: "SmilingHeart.sks")!
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 1)
        // bg color
        backgroundColor = .clear
        
        // creating node and adding to scene
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        node.particleBirthRate = birthRate
    }
}

class BlowingKissRain: SKScene {
    var birthRate: CGFloat = 0.0;
    var node = SKEmitterNode(fileNamed: "BlowingKiss.sks")!
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 1)
        // bg color
        backgroundColor = .clear
        
        // creating node and adding to scene
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        node.particleBirthRate = birthRate
    }
}

class SparklesRain: SKScene {
    var birthRate: CGFloat = 0.0;
    var node = SKEmitterNode(fileNamed: "Sparkles.sks")!
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        // anchor point
        anchorPoint = CGPoint(x: 0.5, y: 1)
        // bg color
        backgroundColor = .clear
        
        // creating node and adding to scene
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width
        node.particleBirthRate = birthRate
    }
}
