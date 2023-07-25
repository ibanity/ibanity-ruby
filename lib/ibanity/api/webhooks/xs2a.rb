module Ibanity
  module Webhooks
    module Xs2a
      module Synchronization
        class SucceededWithoutChange < Ibanity::BaseResource
        end

        class Failed < Ibanity::BaseResource
        end
      end

      module Account
        class DetailsUpdated < Ibanity::BaseResource
        end

        class TransactionsCreated < Ibanity::BaseResource
        end

        class TransactionsDeleted < Ibanity::BaseResource
        end

        class TransactionsUpdated < Ibanity::BaseResource
        end

        class PendingTransactionsCreated < Ibanity::BaseResource
        end

        class PendingTransactionsUpdated < Ibanity::BaseResource
        end
      end

      module BulkPaymentInitiationRequest
        class AuthorizationCompleted < Ibanity::BaseResource
        end

        class StatusUpdated < Ibanity::BaseResource
        end
      end

      module PaymentInitiationRequest
        class AuthorizationCompleted < Ibanity::BaseResource
        end

        class StatusUpdated < Ibanity::BaseResource
        end
      end

      module PeriodicPaymentInitiationRequest
        class AuthorizationCompleted < Ibanity::BaseResource
        end

        class StatusUpdated < Ibanity::BaseResource
        end
      end
    end
  end
end
