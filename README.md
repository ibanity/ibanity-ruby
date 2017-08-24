# Ibanity Ruby Client

## Usage

* Install

    ```
    gem install "ibanity"
    ```

* Use

    ```ruby
    Ibanity.configure do |config|
      config.certificate    = ENV["IBANITY_CERTIFICATE"]
      config.key            = ENV["IBANITY_KEY"]
      config.key_passphrase = ENV["IBANITY_PASSPHRASE"]
    end

    puts Ibanity::Customer.all
    puts Ibanity::Customer.all.first.accounts
    ```
