//
//  Divisi.swift
//  UMKM
//
//  Created by Kevin  Dwi on 07/09/22.
//

import Foundation

struct Divisi: Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
}

let divisis = [
    Divisi(name: "Humas"),
    Divisi(name: "Sekertariat"),
    Divisi(name: "Sosmed"),
    Divisi(name: "Lainnya"),
]
