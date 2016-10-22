//
//  CrisisCard+CoreDataClass.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/18/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import Foundation
import CoreData


public class CrisisCard: NSManagedObject {
    
    enum CrisisType: Int {
        case UNDEFINED = -1
        case BRAINWASHING = 0
        case CHASE = 1
        case HACKING = 2
        case INFILTRATION = 3
        case INTERROGATION = 4
        case MANHUNT = 5
        case SEDUCTION = 6
    }
    
    convenience init(context: NSManagedObjectContext!, name: String!, desc: String?, strategy: String?, special: String?, skill: String?, duration: String?, requirements: String?, advantages: String?, skillmod: String?, crisisType: String!) {
        let entity = NSEntityDescription.entity(forEntityName: "CrisisCard", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.name = name
        self.desc = desc
        self.strategy = strategy
        self.special = special
        self.skill = skill
        self.duration = duration
        self.requirements = requirements
        self.advantages = advantages
        self.skillmod = skillmod
        self.crisistype = crisisType
    }
    
    // MARK: - Getters
    public func getCleanedStrategy() -> String {
        if let strategy = self.strategy {
            return strategy.replacingOccurrences(of: "Strategy: ", with: "")
        }
        return ""
    }
    
    public func getCleanedSkill() -> String {
        if let skill = self.skill {
            return skill.replacingOccurrences(of: "Skill: ", with: "")
        }
        return ""
    }
    
    public func getCleanedRequirements() -> String {
        if let reqs = self.requirements {
            return reqs.replacingOccurrences(of: "Requirements: ", with: "")
        }
        return ""
    }
    
    public func getCleanedSkillMod() -> String {
        if let skillMod = self.skillmod {
            return skillMod.replacingOccurrences(of: "Skill Check Modifier: ", with: "")
        }
        return ""
    }
    
    public func getCleanedSpecialspecial() -> String {
        if let special = self.skillmod {
            return special.replacingOccurrences(of: "Special: ", with: "")
        }
        return ""
    }
    
    public func getCleanedAdvantages() -> String {
        if let advantages = self.strategy {
            return advantages.replacingOccurrences(of: "Strategy: ", with: "")
        }
        return ""
    }
    
    // MARK: - Private Methods
    
    
    //MARK: - Public Methods
    
    func crisisTypeForString(str: String) -> CrisisType {
        switch str {
        case "BRAINWASHING":
            return .BRAINWASHING
        case "CHASE":
            return .CHASE
        case "HACKING":
            return .HACKING
        case "INFILTRATION":
            return .INFILTRATION
        case "INTERROGATION":
            return .INTERROGATION
        case "MANHUNT":
            return .MANHUNT
        case "SEDUCTION":
            return .SEDUCTION
        default:
            return .UNDEFINED
        }
    }
}
