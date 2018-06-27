//
//  ViewController.swift
//  NView
//
//  Created by Vlad on 06/27/2018.
//  Copyright (c) 2018 Vlad. All rights reserved.
//

import UIKit
import NView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnTapped() {
        NotificationView.show(withImage: UIImage(named:"icon"), title: "This particular icon", message: "It has two lines inside towards the top that looks like a hair line. ", duration: 4, size: CGSize(width: 40, height: 40))
    }
}

