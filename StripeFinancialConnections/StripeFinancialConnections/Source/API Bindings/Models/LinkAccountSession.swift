//
//  LinkAccountSession.swift
//  StripeFinancialConnections
//
//  Created by Vardges Avetisyan on 1/19/22.
//

import Foundation
@_spi(STP) import StripeCore

public extension StripeAPI {

    struct LinkAccountSession {

        // MARK: - Types

        @_spi(STP) public enum PaymentAccount: Decodable {

            // MARK: - Types

            @_spi(STP) public struct BankAccount: Decodable {
                public let bankName: String?
                public let id: String
                public let last4: String
                public let routingNumber: String?
            }

            case linkedAccount(StripeAPI.LinkedAccount)
            case bankAccount(StripeAPI.LinkAccountSession.PaymentAccount.BankAccount)
            case unparsable

            // MARK: - Decodable

            /**
             Per API specification paymentAccount is a polymorphic field denoted by openAPI anyOf modifier.
             We are translating it to an enum with associated types.
             */
            public init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                if let value = try? container.decode(LinkedAccount.self) {
                    self = .linkedAccount(value)
                } else if let value = try? container.decode(LinkAccountSession.PaymentAccount.BankAccount.self) {
                    self = .bankAccount(value)
                } else {
                    self = .unparsable
                }
            }
        }

        // MARK: - Properties

        public let clientSecret: String
        public let id: String
        public let linkedAccounts: LinkedAccountList
        public let livemode: Bool
        @_spi(STP) public let paymentAccount: PaymentAccount?
        @_spi(STP) public let bankAccountToken: BankAccountToken?

        // MARK: - Internal Init

        internal init(clientSecret: String,
                      id: String,
                      linkedAccounts: LinkedAccountList,
                      livemode: Bool,
                      paymentAccount: PaymentAccount?,
                      bankAccountToken: BankAccountToken?) {
            self.clientSecret = clientSecret
            self.id = id
            self.linkedAccounts = linkedAccounts
            self.livemode = livemode
            self.paymentAccount = paymentAccount
            self.bankAccountToken = bankAccountToken
        }
    }
}


// MARK: - Decodable

@_spi(STP) extension StripeAPI.LinkAccountSession: Decodable {}
