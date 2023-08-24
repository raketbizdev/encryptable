# Encryptable

`Encryptable` is a lightweight and versatile Ruby gem crafted to provide seamless encryption and decryption functionalities. Whether you're building a standalone Ruby application or a Rails-powered web service, Encryptable allows you to maintain the confidentiality of your data with ease.

### Features:

- **`AES-256-CBC Algorithm:`** By default, Encryptable uses the robust and widely recognized AES-256-CBC encryption algorithm, ensuring that your data remains secure.

- **`Base64 Encoding:`** After encryption, the data is encoded in Base64 format, making it easier to store in databases or transmit over networks.

- **`Customizable Key and IV:`** While the gem provides methods to generate secure keys and initialization vectors (IVs), users can also provide their own to tailor the encryption process to their needs.

- **`Error Handling:`** Transparent error messages are provided for common issues such as invalid Base64 strings or incorrect key/IV lengths, making debugging a breeze.

- **`Rails Integration:`** Easily integrate **`Encryptable`** with Rails models to encrypt sensitive attributes before storing them in your database.

Whether you're looking to securely store user passwords, encrypt sensitive configuration data, or simply want an easy-to-use encryption tool, Encryptable has got you covered!

## Usage

### Setup

1. First, make sure you have added the encryptable gem to your Gemfile:

   ```
   gem 'encryptable'
   ```

2. Run bundle install to install the gem.

3. Create an initializer for the Encryptable configuration. This can be done in **`config/initializers/encryptable.rb`:**

   ```ruby
   # config/initializers/encryptable.rb

   Encryptable.configure do |config|
   # You might want to use Rails secrets or credentials to store these values
   config.key = Rails.application.credentials.encryptable[:key] || "YOUR_DEFAULT_KEY"
   config.iv = Rails.application.credentials.encryptable[:iv] || "YOUR_DEFAULT_IV"
   end
   ```

### Basic Usage

```ruby
# Encryption
plaintext = "Ruel Nopal"
encrypted_text = Encryptable.cipher.encrypt(plaintext)
puts "Encrypted Text: #{encrypted_text}"

# Decryption
decrypted_text = Encryptable.cipher.decrypt(encrypted_text)
puts "Decrypted Text: #{decrypted_text}"

```

### Generating Key and IV

To generate a secure key and IV, you can use the following code:

```ruby
require "openssl"

def generate_key_iv(key_length: 32, iv_length: 16)
  key = OpenSSL::Random.random_bytes(key_length)
  iv = OpenSSL::Random.random_bytes(iv_length)

  # Convert them to base64 format (easier to store in environment variables)
  key_base64 = [key].pack("m0")
  iv_base64 = [iv].pack("m0")

  [key_base64, iv_base64]
end

# Default values
key_base64, iv_base64 = generate_key_iv
puts "Key (Default): #{key_base64}"
puts "IV (Default): #{iv_base64}"

# Example with custom values
# key_base64, iv_base64 = generate_key_iv(key_length: 24, iv_length: 12)
# puts "Key (Custom): #{key_base64}"
# puts "IV (Custom): #{iv_base64}"
```

After generating the key and IV, you can use them in the Encryptable configuration as shown in the basic usage example.

### Using with Rails Models

Consider a **`Profile`** model where you want to save encrypted **`first_name`** and **`last_name`**.

```ruby
class Profile < ApplicationRecord
  before_save :encrypt_name

  private

  def encrypt_name
    self.first_name = Encryptable.cipher.encrypt(self.first_name)
    self.last_name = Encryptable.cipher.encrypt(self.last_name)
  end
end
```

When saving the profile:

```ruby
profile = Profile.new(first_name: "Ruel", last_name: "Nopal")
profile.save # The names will be encrypted before saving
```

To decrypt them when needed:

```ruby
decrypted_first_name = Encryptable.cipher.decrypt(profile.first_name)
decrypted_last_name = Encryptable.cipher.decrypt(profile.last_name)
```

## Development

If you'd like to contribute to this gem:

1. Fork the repository.
2. Clone your fork and create a new branch for your feature or fix.
3. Install dependencies with `bundle install`.
4. Make your changes and ensure tests pass with `bundle exec rspec`.
5. Commit your changes and push to your branch.
6. Open a pull request.

All contributions are greatly appreciated. Make sure to add tests for new features and bug fixes!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Encryptable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/raketbizdev/encryptable/blob/main/CODE_OF_CONDUCT.md).
