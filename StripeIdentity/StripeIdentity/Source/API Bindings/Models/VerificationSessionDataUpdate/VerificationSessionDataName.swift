//
//  VerificationSessionDataName.swift
//  StripeIdentity
//
//  Created by Mel Ludowise on 11/2/21.
//

import Foundation
@_spi(STP) import StripeCore

struct VerificationSessionDataName: StripeEncodable, Equatable {

    let firstName: String?
    let lastName: String?

    var _additionalParametersStorage: NonEncodableParameters?
}
