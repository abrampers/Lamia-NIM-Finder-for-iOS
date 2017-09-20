//
//  Mahasiswa.swift
//  Lamia
//
//  Created by Abram Situmorang on 8/20/17.
//  Copyright © 2017 abrampers. All rights reserved.
//
import Foundation
import UIKit

// MARK: - Mahasiswa

struct Mahasiswa {
    
    // MARK: Properties
    
    let name: String
    let major: String
    let NIM_TPB: String
    let NIM_Major: String
    let email: String
    
    static let NameKey = "name"
    static let MajorKey = "major"
    static let NIMTPBKey = "nim_tpb"
    static let NIMMajorKey = "nim_prodi"
    static let EmailKey = "email"
    
    // MARK: Initializer
    
    // Generate a Mahasiswa from a three entry dictionary
    
    init(dictionary: [String : String]) {
        
        self.name = dictionary[Mahasiswa.NameKey]!
        self.major = dictionary[Mahasiswa.MajorKey]!
        self.NIM_TPB = dictionary[Mahasiswa.NIMTPBKey]!
        self.NIM_Major = dictionary[Mahasiswa.NIMMajorKey]!
        self.email = dictionary[Mahasiswa.EmailKey]!
        
    }
}

