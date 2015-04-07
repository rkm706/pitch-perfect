//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Rob Mackey (rkm706@gmail.com) on 4/6/15.
//  Copyright (c) 2015 Rob Mackey. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}