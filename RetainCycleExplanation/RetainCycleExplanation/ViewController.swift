//
//  ViewController.swift
//  RetainCycleExplanation
//
//  Created by Ali Mert Kaya on 14.09.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        var course : Course? = Course(name: "iOS", url: URL(string: "www.ioscourse.com")!)
        var instructor : Instructor? = Instructor(name: "Mert")
        
        // strong reference, retain cycle
        course?.instructor = instructor
        instructor?.course = course
        
        course = nil
        instructor = nil
         */
        
        /*
        var course : WeakCourse? = WeakCourse(name: "iOS", url: URL(string: "www.ioscourse.com")!)
        var instructor : WeakInstructor? = WeakInstructor(name: "Mert")
        
        // weak reference
        course?.instructor = instructor
        instructor?.course = course
        
        course = nil
        instructor = nil
         */
        
        var course : WeakCourse2? = WeakCourse2(name: "iOS", url: URL(string: "www.ioscourse.com")!)
        var instructor : WeakInstructor2? = WeakInstructor2(name: "Mert")
        
        // weak reference
        course?.instructor = instructor
        instructor?.course = course
        
        course?.launch(launchedCourse: LaunchedCourse(title: "iOS"))
        
        course = nil
        instructor = nil
    }
}
