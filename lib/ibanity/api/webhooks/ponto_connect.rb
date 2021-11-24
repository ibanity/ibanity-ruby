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
      end
    end
  end
end
