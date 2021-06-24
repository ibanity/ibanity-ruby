# Changelog

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
