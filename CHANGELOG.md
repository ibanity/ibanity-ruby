# Changelog

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
