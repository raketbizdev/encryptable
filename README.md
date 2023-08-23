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

### Introduction

Once you have successfully installed the `Encryptable` gem, implementing encryption and decryption in your application becomes a breeze. This section will guide you through the process of utilizing the gem's functionalities effectively.

### Configuration

Before you begin using the gem, it's important to set it up properly:

1. **Initialize the Configuration**:

   Create an initializer for the gem if you haven't already. In `config/initializers/encryptable.rb`:

   ```
   Encryptable.configure do |config|
     config.key = ENV["ENCRYPTION_KEY"]
     config.iv = ENV["ENCRYPTION_IV"]
   end
   ```

   Ensure that the `ENCRYPTION_KEY` and `ENCRYPTION_IV` environment variables are set up securely in your application.

### Encrypting Data

To encrypt a piece of data:

```
encrypted_data = Encryptable.cipher.encrypt("YourSensitiveData")
```

This will return an encrypted string which you can store securely.

### Decrypting Data

To decrypt an encrypted piece of data:

```
decrypted_data = Encryptable.cipher.decrypt(encrypted_data)
```

This will return the original data before encryption.

### Best Practices

1. **Securely Store Keys and IVs**: Always ensure that encryption keys and initialization vectors (IVs) are stored securely using environment variables, encrypted credentials, or secret management tools. They should never be hard-coded or checked into version control.
2. **Regularly Rotate Keys**: For enhanced security, consider rotating your encryption keys periodically.

3. **Backup Encrypted Data**: Always keep backups of your encrypted data to prevent data loss.

4. **Test Before Deploying**: Before deploying changes related to encryption in your production environment, thoroughly test them in a staging or development environment to ensure there are no issues.

## Development

### Introduction

Contributing to the development of the `Encryptable` gem? This section will guide you through setting up your development environment, running tests, and making contributions.

### Setting Up the Development Environment

1. **Clone the Repository**:

   Begin by cloning the `Encryptable` gem repository to your local machine.

   ```
   $ git clone https://github.com/raketbizdev/encryptable.git
   ```

2. **Navigate to the Project Directory**:

   ```
   $ cd encryptable
   ```

3. **Install Dependencies**:

   After checking out the repo, install the necessary dependencies.

   ```
   $ bin/setup
   ```

### Running Tests

Ensure that the gem's functionalities are working as expected by running the test suite:

```
$ rake spec
```

All tests should pass before you make a contribution or push changes.

### Interactive Console

For an interactive prompt that allows you to experiment with the gem's codebase, run:

```
$ bin/console
```

### Making Contributions

1. **Create a Feature Branch**:

   It's a good practice to create a new branch for each feature or bugfix.

   ```
   $ git checkout -b my-new-feature
   ```

2. **Commit Your Changes**:

   After making modifications or adding new features, commit your changes.

   ```
   $ git commit -am 'Add some feature'
   ```

3. **Push to the Branch**:

   ```
   $ git push origin my-new-feature
   ```

4. **Open a Pull Request**:

   Once you've pushed your feature branch to the repository, open a new pull request for review.

### Releasing a New Version

If you have the necessary permissions and are looking to release a new version:

1. Update the version number in `lib/encryptable/version.rb`.
2. Run the release tasks to create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org):

   ```
   $ bundle exec rake release
   ```

## Contributing

### Introduction

Contributions to the `Encryptable` gem are always welcome, whether it's in the form of bug reports, feature suggestions, or pull requests. This section provides guidelines on how you can contribute and make the gem even better!

### Reporting Bugs

1. **Check Existing Issues**: Before submitting a bug report, please check the [issue tracker](https://github.com/raketbizdev/encryptable/issues) to see if the problem has already been reported. If it has, feel free to add any additional information to the existing issue.

2. **Open a New Issue**: If you don't find your problem listed, [open a new issue](https://github.com/raketbizdev/encryptable/issues/new). Please provide as much detail as possible, including steps to reproduce, the expected behavior, and any error messages you receive.

### Suggesting Enhancements

1. **Check Existing Issues**: Before submitting a feature request or enhancement, please check the [issue tracker](https://github.com/raketbizdev/encryptable/issues) to see if someone has already suggested it.

2. **Open a New Issue**: If your suggestion hasn't been raised, [open a new issue](https://github.com/raketbizdev/encryptable/issues/new) and describe the feature or enhancement in detail. Explain why you believe it would be beneficial and how it should work.

### Submitting Pull Requests

1. **Fork the Repository**: Start by forking the `Encryptable` repository.

2. **Clone Your Fork Locally**:

   ```
   $ git clone https://github.com/[YOUR_USERNAME]/encryptable.git
   ```

3. **Create a New Branch**: Always create a new branch for your changes:

   ```
   $ git checkout -b my-feature-branch
   ```

4. **Make Your Changes**: Implement your feature or bug fix.

5. **Run the Tests**: Ensure that all tests pass:

   ```
   $ rake spec
   ```

6. **Commit Your Changes**:

   ```
   $ git commit -am 'Description of my changes'
   ```

7. **Push to Your Fork**:

   ```
   $ git push origin my-feature-branch
   ```

8. **Open a Pull Request**: Go to the [Encryptable repository](https://github.com/raketbizdev/encryptable) and open a new pull request from your feature branch.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Encryptable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/raketbizdev/encryptable/blob/main/CODE_OF_CONDUCT.md).
