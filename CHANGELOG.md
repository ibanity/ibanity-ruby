# Changelog

## 2.3

* [Ponto Connect] Add IntegrationAccount
* [XS2A] Add PendingTransaction
* [XS2A] Add additional webhooks event

  * `Ibanity::Webhooks::Xs2a::Account::PendingTransactionsCreated`
  * `Ibanity::Webhooks::Xs2a::Account::PendingTransactionsUpdated`

## 2.2

* [Ponto Connect] Add additional webhook events
  * `Ibanity::Webhooks::Account::Reauthorized`
  * `Ibanity::Webhooks::Integration::AccountAdded`
  * `Ibanity::Webhooks::Integration::AccountRevoked`
  * `Ibanity::Webhooks::Integration::Created`
  * `Ibanity::Webhooks::Integration::Revoked`
  * `Ibanity::Webhooks::Organization::Blocked`
  * `Ibanity::Webhooks::Organization::Unblocked`

## 2.1

* [XS2A] Include Bulk & Periodic Payments, with Authorization for TPP managed flow

## 2.0.1

* [Ponto Connect] Fix UpdatedTransactions relationship parsing for synchronization
* [XS2A] Fix initialAccountTransactionsSynchronizations relationship parsing for accountInformationAccessRequest

## 2.0

* [Isabel Connect] Upgrade to version 2 of the API.

## 1.11

* Allow to tweak RestClient's timeout.

## 1.10

* [Ponto Connect] Add support for payment activation requests.

* [Webhooks] Add support for webhook signature validation, keys endpoint, and events.

## 1.9

* [Ponto Connect] Add account reauthorization requests

* [Isabel Connect] Deprecate `Ibanity::IsabelConnect::AccessToken` and `Ibanity::IsabelConnect::RefreshToken`, please use `Ibanity::IsabelConnect::Token` instead

## 1.8

* [XS2A] Update sandbox transactions

* [XS2A] Add support to list updated transaction using `synchronization_id`

* [Ponto Connect] Add support to BulkPayments

* [Isabel Connect] Add `hideDetails` and `isShared` parameters to `BulkPaymentInititationRequest.create`

## 1.7
### Enhancements

* [Ponto Connect] Add support for the /onboarding-details endpoint.

## 1.6
### Enhancements

* [Ponto Connect] Added a new revoke account endpoint. It allows to remove an account from your integration. (The bank account will not be deleted from the Ponto account itself).

* [Ponto Connect] Added a new delete organization integration endpoint. It provides an alternative method to revoke the integration (in addition to the revoke refresh token endpoint). This endpoint remains accessible with a client access token, even if your refresh token is lost or expired.

## 1.5

* Proper release of previous enhancements

## 1.4

*Don't use this version as it was not properly released !*

## 1.3

### Enhancements

* [Ponto Connect] Add support for the /userinfo and /organizations/{id}/usage endpoints.

## 1.2

### Enhancements

* Default signature algorithm is now ["hs2019"](https://tools.ietf.org/html/draft-cavage-http-signatures-12#appendix-E.2)
* Add support for periodic and bulk payments
* Add snake-case transformation for deeply nested data structures

## 1.1.1

### Enhancements

* Improve debugging by logging the `ibanity_request_id` header from the response in case of error
