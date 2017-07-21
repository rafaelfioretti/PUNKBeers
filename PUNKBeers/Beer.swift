//
//  Beer.swift
//  PUNKBeers.
//
//  Created by Rafael Fioretti on 7/18/17.
//  Copyright © 2017 RafaelFioretti. All rights reserved.
//

import Foundation

class Beer {
    var id: Int!
    var name: String!
    var tag: String!
    var description: String!
    var teor: Float!
    var ibu: Float!
    var url: String!
    
    
    init (id: Int, name: String, url: String, teor: Float, tag: String, ibu: Float, description: String){
        self.id = id
        self.name = name
        self.url = url
        self.teor = teor
        self.tag = tag
        self.ibu = ibu
        self.description = description
        
        
    }

    
}

