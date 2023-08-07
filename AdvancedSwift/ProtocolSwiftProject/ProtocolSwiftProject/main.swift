//
//  main.swift
//  ProtocolSwiftProject
//
//  Created by Ali Mert Kaya on 7.08.2023.
//

import Foundation

protocol Runnnig {
    func myRun()
}

class Animal {
    func test() {
        print("test")
    }
}

class Dog : Runnnig {
    func myRun() {
        print("running")
    }
}
let barley = Dog()
barley.myRun()

class Cat : Animal, Runnnig {
    func myRun() {
        print("running")
    }
}

let cat = Cat()
cat.test()
cat.myRun()

struct Bird : Runnnig {
    func myRun() {
        print("running")
    }
}
let tweety = Bird()
tweety.myRun()
