# Encryptable

The `Encryptable` gem provides an easy-to-use module for encrypting and decrypting data in Ruby on Rails applications. It utilizes the AES-256-CBC encryption method from the OpenSSL library.

## Installation

### Introduction

The `Encryptable` gem offers seamless integration for encryption and decryption functionalities within Ruby on Rails applications. Leveraging the robustness of the AES-256-CBC encryption method from the OpenSSL library, `Encryptable` ensures that your application's sensitive data remains secure. Below are the steps to get you started with the installation process.

### Step-by-Step Guide

1. **Add the Gem to Your Gemfile**:

   Integrate the `encryptable` gem into your Rails application by adding the following line to your application's Gemfile:

   ```
   gem 'encryptable', git: 'https://github.com/raketbizdev/encryptable.git'
   ```

2. **Install the Gem**:

   After adding the gem to your Gemfile, install it using Bundler. Run the following command in your terminal:

   ```
   $ bundle install
   ```

3. **Configuration (Optional)**:

   If the gem requires specific configurations, such as setting up an encryption key or an initialization vector (IV), you might need to do so in an initializer. For instance, you can create an initializer in `config/initializers/encryptable.rb` and add the necessary configurations there.

   Note: Always ensure that sensitive configuration values, like encryption keys, are stored securely using environment variables or encrypted credentials, and are never hard-coded or checked into version control.

### Verification

To verify that the gem has been installed correctly, you can run the following command:

```
$ bundle list | grep encryptable
```

If the gem is installed successfully, this command will display its version and confirm its presence in your bundle.

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
