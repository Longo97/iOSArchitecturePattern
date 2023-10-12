//
//  EntityModelMapProtocol.swift
//  MVC
//
//  Created by Marco Longobardi on 06/10/23.
//

import Foundation
import CoreData

/// Protocol that the models must comply to trasform model to entity and viceversa
protocol EntityModelMapProtocol {
    associatedtype EntityType: NSManagedObject
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
    static func mapFromEntity(_ entity: EntityType) -> Self
}
