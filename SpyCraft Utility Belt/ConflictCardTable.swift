//
//  ConflictCardTable.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import Foundation
import SQLite

public class ConflictCardTable {
    
    enum ConflictStrategyType: Int {
        case Predator = 0
        case Prey = 1
        case Both = 2
    }
    
    let dbManager = HSDatabaseManager().db
    let confictCardTable = Table("conflict_card_table")
    let id = Expression<String>("id")
    let name = Expression<String>("name")
    let description = Expression<String>("description")
    let strategy = Expression<Int>("strategy")
    let skill = Expression<String>("skill")
    let requirments = Expression<String>("requirments")
    let skillCheckModifier = Expression<Int>("skill_check_modifier")
    let advantages = Expression<String>("advantages")
    
    public init() {
        buildConflictCardTable()
    }
    
    private func buildConflictCardTable() {
        do {
            try dbManager.run(self.confictCardTable.create { t in
                t.column(self.id)
                t.column(self.name)
                t.column(self.description)
                t.column(self.strategy)
                t.column(self.skill)
                t.column(self.requirments)
                t.column(self.skillCheckModifier)
                t.column(self.advantages)
            })
        } catch {
            
        }
    }
}
