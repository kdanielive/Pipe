//
//  FBStorage.swift
//  Pipe
//
//  Created by Daniel Kim on 8/12/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import Foundation
import Firebase

class fbManager {
    init() {
        FirebaseApp.configure()
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        print("StorageRef info: ", storageRef.fullPath, storageRef.name, storageRef.bucket)
        let videoRef = storageRef.child("video1.mp4")
        print("VideoRef info: ", videoRef.fullPath, videoRef.name, videoRef.bucket)

    }
}
