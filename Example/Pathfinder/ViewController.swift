//
//  ViewController.swift
//  Pathfinder
//
//  Created by Medvedev Semyon on 07/19/2021.
//  Copyright (c) 2021 Medvedev Semyon. All rights reserved.
//

import UIKit
import Pathfinder

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pfOpenTapped(_ sender: Any) {
        present(Pathfinder.shared.makeController(), animated: true)
    }


    @IBAction func pfLogTapped(_ sender: Any) {
        if let url = try? Pathfinder.shared.buildUrl(id: "auth", pathParameters: [:], queryParameters: [:]) {
            print(url)
        } else {
            fatalError("Unable to resolve URL")
        }
    }
}

