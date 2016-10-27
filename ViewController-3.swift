//
//  ViewController.swift
//  Proyecto
//
//  Created by inf227al on 30/09/16.
//  Copyright © 2016 ECVC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

  @IBOutlet weak var varrr: UIButton!
  
  @IBOutlet weak var nombre: UILabel!
  
    //Esta es la función probamos en el laboratorio, usa semaforos 
    //por que Alamofire.request es otro hilo. Versión antigua alamofire y pod (0...)
  func getJSON(url: String) -> JSON {
    let url = url
    var title = ""
    var json: JSON = []
    let semaphore = dispatch_semaphore_create(0)
    Alamofire.request(.GET, url).response { response in
      let jsonDict = JSON(data: response.2!)
      json = jsonDict
      title = String(jsonDict["items"][0]["volumeInfo"]["title"])
      dispatch_semaphore_signal(semaphore)
    }
    //Wait for the request to complete
    while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) != 0 {
      NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 10))
    }
    print(json.description)
    return json
  }
  
    
  @IBAction func press(sender: AnyObject) {
    print("presionado")
    getJSON("https://httpbin.org/get")
    /*
    let todoEndpoint: String = "https://httpbin.org/get"
    //let todoEndpoint: String = "http://52.89.227.55/studentsResult"
    print("----------------------------------***********************--------------")
    
    Alamofire.request(.GET,todoEndpoint)
      .responseJSON { response in
        
        
        print("Continua: ---------------------")
        if let json = response.result.value {
          print("JSON: \(json)")
        }
        print("Fin: ---------------------")
        
        if let value = response.result.value {
          // handle the results as JSON, without a bunch of nested if loops
          let todo = JSON(value)
          // now we have the results, let's just print them though a tableview would definitely be better UI:
          print("The todo is: " + todo.description)
          if let title = todo["origin"].string {
            // to access a field:
            print("The title is: " + title)
            self.nombre.text = title
          } else {
            print("error parsing /todos/1")
          }
          
          if  todo["headers"].isEmpty {
            // to access a field:
            print("The title si: ")
          } else {
            print("No error parsing /todos/1",todo["headers"])
          }
          
          
        }
    }*/

    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    let todoEndpoint: String = "https://httpbin.org/get"
    print("----------------------------------***********************--------------")
    
    Alamofire.request(.GET,todoEndpoint)
      .responseJSON { response in
        
        
        print("Continua: ---------------------")
        if let json = response.result.value {
          print("JSON: \(json)")
        }
        print("Fin: ---------------------")
        
        if let value = response.result.value {
          // handle the results as JSON, without a bunch of nested if loops
          let todo = JSON(value)
          // now we have the results, let's just print them though a tableview would definitely be better UI:
          print("The todo is: " + todo.description)
          if let title = todo["origin"].string {
            // to access a field:
            print("The title is: " + title)
            //self.nombre.text = title
          } else {
            print("error parsing /todos/1")
          }
          
          if  todo["headers"].isEmpty {
            // to access a field:
            print("The title si: ")
          } else {
            print("No error parsing /todos/1",todo["headers"])
          }
          
          
        }
    }
    
    */
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

