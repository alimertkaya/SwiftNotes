//
//  main.swift
//  AdvancedSwiftProject
//
//  Created by Ali Mert Kaya on 7.08.2023.
//

import Foundation

let classJames = MusicianClass(name: "James", age: 50, instrument: "Guitar")
// print(classJames.age)

var structJames = MusicianStruct(name: "James", age: 50, instrument: "Guitar")
// print(structJames.age)

// IMMUTABLE STRUCT
/*
    Eğer object struct olarak oluşturulduysa ve değişkeni let ise değerlerine ulaşıp değiştiremeyiz
    Değerini değiştirme istiyorsak değişkeni var ile tanımlamamız gerek, class larda böyle bir durum yok
    let structJames = MusicianStruct(name: "James", age: 50, instrument: "Guitar") da
    let -> var olmalı ki değerlerine ulaşıp değiştirilebilir
 */
classJames.age = 51
// print(classJames.age)

structJames.age = 51
// print(structJames.age)

// REFERENCE vs VALUE

let copyOfClassJames = classJames

var copyOfStructJames = structJames

// print(copyOfClassJames)
// print(copyOfStructJames)

copyOfClassJames.age = 52
copyOfStructJames.age = 52

// print(copyOfClassJames.age)
// print(copyOfStructJames.age)

// print(classJames.age)
// print(structJames.age)

/*
    Reference Types -> Class
    Copy -> Same object new reference -> 1 object + 2 Reference
 
    Value Types -> Struct
    Copy -> new object -> 2 Objects
 */

// Function vs Mutating Function

// print(classJames.age)
classJames.happyBirthday()
// print(classJames.age)

// print(structJames.age)
structJames.happyBirthday()
// print(structJames.age)


// TUPLE
// Birden fazla değişkeni yani veriyi aynı collection içerisinde göstermeyi sağlar
/*
let myTuple = (1,3)
print(myTuple.0)

let myTuple2 = (1,3,5)
print(myTuple2.2)

let myTuple3 = ("LOTR", 2001)
print(myTuple3.0)

let myTuple4 = (10,[10,20,30])
print(myTuple4.1[1])

let predefinedTuple : (String, Int)
predefinedTuple.0 = "LOTR"
predefinedTuple.1 = 2001
print(predefinedTuple)

let newTuple = (namee: "LOTR", datee: 2001)
print(newTuple.namee)
print(newTuple.datee)
*/

// Guard Let vs If let

// Guard -> Negative && Confident
// If -> Positive

let myNumber = "5"

func convertToIntegerGuard (stringInput : String) -> Int {
    // Bunu yapacaksın yapamazsan ne olucak, kendine daha çok güveniyor gibi düşün
    guard let myInteger = Int(stringInput) else {
        return 0
    }
    return myInteger
}

func convertToIntegerIf (stringInput : String) -> Int {
    // Yapabilirsen yap
    if let myInteger = Int(stringInput) {
        return myInteger
    }
    else {
        return 0
    }
}

// print(convertToIntegerGuard(stringInput: myNumber))
// print(convertToIntegerIf(stringInput: myNumber))


