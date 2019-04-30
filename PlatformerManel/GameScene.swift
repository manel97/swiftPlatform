//
//  GameScene.swift
//  PlatformerManel
//
//  Created by Manel Sitjar on 23/04/2019.
//  Copyright © 2019 Manel Sitjar. All rights reserved.
// https://code.tutsplus.com/tutorials/spritekit-from-scratch-physics-and-collisions--cms-26413

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "background")
    var heroe = SKSpriteNode(imageNamed: "elprimo")
    let buttonLeft = SKSpriteNode(imageNamed: "left")
    let buttonRight = SKSpriteNode(imageNamed: "right")
    let buttonAttack = SKSpriteNode(imageNamed: "attack")
    var suelo = SKSpriteNode(imageNamed: "platform")
    
    let kheroeCategory: UInt32 = 0x1 << 0
    let ksueloCategory: UInt32 = 0x1 << 1
    let ksceneEdgeCategory: UInt32 = 0x1 << 2
    
    
    override func didMove(to view: SKView) {
        
        //añadir fondo, una posicion
        buttonLeft.size = CGSize(width: (self.size.width) / 12, height: (self.size.height) / 9)
        buttonLeft.name = "buttonLeft"
        buttonRight.size = CGSize(width: (self.size.width) / 12, height: (self.size.height) / 9)
        buttonRight.name = "buttonRight"
        buttonAttack.size = CGSize(width: (self.size.width) / 13, height: (self.size.height) / 10)
        buttonAttack.name = "buttonAttack"
        
        buttonLeft.position = CGPoint(x: -250, y: -125)
        buttonRight.position = CGPoint(x: -190, y: -125)
        buttonAttack.position = CGPoint(x: 250, y: -125)
        
        let textHeroe = SKTexture(imageNamed: "elprimo")
        heroe = SKSpriteNode(texture: textHeroe)
        heroe.size = CGSize(width: (self.size.width) / 9, height: (self.size.height) / 6)
        heroe.position = CGPoint(x: 0, y: +50)
        heroe.zPosition = 0
        heroe.physicsBody = SKPhysicsBody(rectangleOf: textHeroe.size())
        heroe.physicsBody?.isDynamic = true
        heroe.physicsBody?.affectedByGravity = true
        heroe.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        heroe.physicsBody?.collisionBitMask = ksueloCategory
        
        
        let textPlat = SKTexture(imageNamed: "platform")
        suelo.physicsBody = SKPhysicsBody(rectangleOf: textPlat.size())
        suelo.physicsBody?.affectedByGravity = false
        suelo.physicsBody?.isDynamic = true
        suelo.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        suelo = SKSpriteNode(texture: textPlat)
        suelo.size = CGSize(width: (self.size.width) / 6, height: (self.size.height) / 6)
        suelo.position = CGPoint(x: 0, y: -50)
        suelo.zPosition = 0
        //con quien va a colisionar
        suelo.physicsBody?.collisionBitMask = kheroeCategory
        
        
        background.size = CGSize(width: (self.size.width), height: (self.size.height))
        background.zPosition = -1
        
        self.addChild(heroe)
        self.addChild(suelo)
        self.addChild(background)
        self.addChild(buttonLeft)
        self.addChild(buttonRight)
        self.addChild(buttonAttack)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            let touchedPlace = t.location(in: self)
            let touchedNodes = self.nodes(at: touchedPlace)
            if touchedNodes.count > 0 {
                let actualNode = touchedNodes[0]
                if (actualNode.name == "buttonLeft"){
                    heroe.physicsBody?.velocity = CGVector(dx: -200, dy: 0)
                    print("left")
                }
                if (actualNode.name == "buttonRight"){
                    heroe.physicsBody?.velocity = CGVector(dx: 200, dy: 0)
                     print("right")
                }
                if (actualNode.name == "buttonAttack"){
                    heroe.physicsBody?.velocity = CGVector(dx: 0, dy: 200)
                    print("attack")
                }
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
