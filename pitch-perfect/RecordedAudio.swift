//
//  RecordedAudio.swift
//  pitch-perfect
//
//  Created by Ming Hu on 3/13/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathURL: NSURL!
    var title: String!
    
    init(fileName: String) {
        // Make up a file name
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let pathArray = [dirPath, fileName]
        
        filePathURL = NSURL.fileURLWithPathComponents(pathArray)
    }
}
