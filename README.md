# Ibanity Ruby Library

The Ibanity Ruby Library provide convenient wrappers around the Ibanity API. The object attributes are dynamically defined based on the API response allowing to support minor API changes seamlessly.

## Documentation

Visit our [Ruby API docs](https://documentation.ibanity.com/api/ruby).

## Installation

    ```
    gem install "ibanity"
    ```

### Requirements

* Ruby 2.0+.

## Usage

* Usage

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
