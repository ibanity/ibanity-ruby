module Ibanity
  module Webhooks
    module PontoConnect
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

        class TransactionsUpdated < Ibanity::BaseResource
        end

        class PendingTransactionsCreated < Ibanity::BaseResource
        end

        class PendingTransactionsUpdated < Ibanity::BaseResource
        end

        class Reauthorized < Ibanity::BaseResource
        end
      end

      module Integration
        class AccountAdded < Ibanity::BaseResource
        end

        class AccountRevoked < Ibanity::BaseResource
        end

        class Created < Ibanity::BaseResource
        end

        class Revoked < Ibanity::BaseResource
        end
      end

      module Organization
        class Blocked < Ibanity::BaseResource
        end

        class Unblocked < Ibanity::BaseResource
        end
      end

      module PaymentRequest
        class Closed < Ibanity::BaseResource
        end
      end
    end
  end
end
