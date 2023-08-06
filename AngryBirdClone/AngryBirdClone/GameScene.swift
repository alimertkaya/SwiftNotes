//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Ali Mert Kaya on 3.08.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // SpriteColor oluşturmak gibi, image veya color alır
    // var bird2 = SKSpriteNode()
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false
    var originalPosition : CGPoint?
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType : UInt32 {
        case Bird = 1
        case Box = 2
        // = 3 olmaz 2 + 1 olduğu için 4 denlemeli yeni case eklenirse
    }

    override func didMove(to view: SKView) {
        
        // let texture = SKTexture(imageNamed: "bird")
        // bird2 = SKSpriteNode(texture: texture)
        // bird2.position = CGPoint(x: 0, y: 0)
        // self.frame.width / 16 -> Tüm aygıtlarda daha iyi bir görünüm oluşturmak için, ekranın oranına göre hesaplar
        // bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        // bird2.zPosition = 1
        // self.addChild(bird2)
        
        // Physics Body
        // Bird zemin de kalsın, total bir çerçeve oluşturuyor, sınır çiziyor
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        // Belirlediğimiz nesneler çarpışsın
        self.physicsWorld.contactDelegate = self
        
        // Bird
        // GameScene içinde oluşturulan bird nesnesiyi almak için
        bird = childNode(withName: "bird") as! SKSpriteNode
        let birdTexture = SKTexture(imageNamed: "bird")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 16)
        // Yerçekiminden etkilenmesi
        bird.physicsBody?.affectedByGravity = false
        // Fiziksel simülasyondan etkilensin
        bird.physicsBody?.isDynamic = true
        // Bird kütlesi
        bird.physicsBody?.mass = 0.15
        // Başlangıç konumu
        originalPosition = bird.position
        // Çakışma yaşanınca geri bildiirm verir
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        // Neler ile değebilir,çarpışabilir
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        // Box
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 8, height: boxTexture.size().height / 8)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        // Box sağa sola dönebilir
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.4
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        // Box sağa sola dönebilir
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.4
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        // Box sağa sola dönebilir
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.4
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        // Box sağa sola dönebilir
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.4
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        // Box sağa sola dönebilir
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.4
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        // Label
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
    }
    
    // Belirlediğimiz nesneler çarpışır ise ne olacak
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        // Bir etki uygular
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
        bird.physicsBody?.affectedByGravity = true */
        
        // false ise bird i çekme işlemlerini yap
        if gameStarted == false {
            if let touch = touches.first {
                // Dokunulan noktanın konumu
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            // Dokunulan nokta bird ise
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // false ise bird i çekme işlemlerini yap
        if gameStarted == false {
            if let touch = touches.first {
                // Dokunulan noktanın konumu
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            // Dokunulan nokta bird ise
                            if sprite == bird {
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStarted = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Oyunu resetleme
        if let birdPhysicsBody = bird.physicsBody {
            // Bird in x ve y düzlemindeki hızları ile açısal hızı kontrol edilir
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                // Default ayarlara döndürülür
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                score = 0
                scoreLabel.text = String(score)
                gameStarted = false

            }
        }
    }
}
