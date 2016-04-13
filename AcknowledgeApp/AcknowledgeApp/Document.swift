//
//  Document.swift
//  AcknowledgeApp
//
//  Created by Fhict on 13/04/16.
//  Copyright © 2016 Gregory Lammers. All rights reserved.
//

import Foundation

import Foundation

public class Document: NSObject{
    
    var title: String?
    var type: String?
    var url: String?
    
    init(title: String, type: String, url: String)
    {
        self.title = title
        self.type = type
        self.url = url
    }
}