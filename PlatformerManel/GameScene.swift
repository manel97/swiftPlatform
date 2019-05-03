//
//  GameScene.swift
//  PlatformerManel
//
//  Created by Manel Sitjar on 23/04/2019.
//  Copyright © 2019 Manel Sitjar. All rights reserved.
// https://code.tutsplus.com/tutorials/spritekit-from-scratch-physics-and-collisions--cms-26413

import SpriteKit
import GameplayKit

//delegado de la física
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let kHeroeSize: CGSize = CGSize(width: 30, height: 16)
    let kRedRectangle: CGSize = CGSize(width: 200, height: 95)
    
    let background = SKSpriteNode(imageNamed: "background")
    var heroe = SKSpriteNode(imageNamed: "elprimo")
    let buttonLeft = SKSpriteNode(imageNamed: "left")
    let buttonRight = SKSpriteNode(imageNamed: "right")
    let buttonAttack = SKSpriteNode(imageNamed: "attack")
    var suelo = SKSpriteNode(imageNamed: "platform")
    
    enum tipoNodo: UInt32 {
        case heroe = 1
        case suelo = 2
    }
    
    override func didMove(to view: SKView) {
        //delegado de la física
        self.physicsWorld.contactDelegate = self
        
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
        
        let heroe = SKSpriteNode(imageNamed: "elprimo")
        heroe.size = CGSize(width: (self.size.width) / 9, height: (self.size.height) / 6)
        heroe.position = CGPoint(x: 0, y: 200)
        //es importante que el siguiente tamaño sea correcto para que no tape otros nodos y desaparezcan de la vista
        heroe.physicsBody = SKPhysicsBody(rectangleOf: kHeroeSize)
        heroe.physicsBody?.isDynamic = true
        heroe.physicsBody?.affectedByGravity = true
        //juega con los valores de la masa y desnsidad del heroe y el suelo
        heroe.physicsBody?.mass = 0.00002
    
        //definir bien cual es  nuestro bitmask y con cual podemos hacer colisión
        heroe.physicsBody?.categoryBitMask = tipoNodo.heroe.rawValue
        heroe.physicsBody?.collisionBitMask = tipoNodo.suelo.rawValue

        let suelo = SKSpriteNode(imageNamed: "platform")
        suelo.size = CGSize(width: (self.size.width) / 6, height: (self.size.height) / 6)
        suelo.position = CGPoint(x: 0, y: -50)
        suelo.physicsBody = SKPhysicsBody(rectangleOf: kRedRectangle)
        suelo.physicsBody?.affectedByGravity = false
        suelo.physicsBody?.isDynamic = true
        //juega con los valores de la masa y desnsidad del heroe y el suelo
        suelo.physicsBody?.mass = 10.0

        //definir bien cual es  nuestro bitmask y con cual podemos hacer colisión
        suelo.physicsBody?.categoryBitMask = tipoNodo.suelo.rawValue
        suelo.physicsBody?.collisionBitMask = tipoNodo.heroe.rawValue

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
