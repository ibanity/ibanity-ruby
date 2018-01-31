# Ibanity Ruby Client

## Documentation

Visit our [Ruby API docs](https://documentation.ibanity.com/api/ruby).

## Usage

* Install

    ```
    gem install "ibanity"
    ```

* Use

    Ibanity must be configured using the details of your application on the [Ibanity developer portal](https://developer.ibanity.com).

    ```ruby
    require "ibanity"

    Ibanity.configure do |config|
      config.certificate    = ENV["IBANITY_CERTIFICATE"]
      config.key            = ENV["IBANITY_KEY"]
      config.key_passphrase = ENV["IBANITY_PASSPHRASE"]
    end

    puts Ibanity::FinancialInstitution.list.first
    puts Ibanity::SandboxUser.list
    ```
