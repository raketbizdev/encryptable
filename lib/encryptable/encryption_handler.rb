# frozen_string_literal: true

# standard:ignore Metrics/BlockLength

# encryption_handler.rb

# EncryptionHandler

module EncryptionHandler
  def self.encrypt(value, key, iv, algorithm)
    validate_input(value)
    return if value.nil?
  
    cipher = setup_cipher(key, iv, algorithm)
    encrypted = encrypt_value(cipher, value)
  
    Base64.encode64(encrypted).encode('utf-8')
  rescue OpenSSL::Cipher::CipherError => e
    handle_encryption_error(e)
  end

  private

  def self.validate_input(value)
    unless value.is_a?(String)
      raise 'Encryption failed: The input value should be a string.'
    end
  end

  def self.setup_cipher(key, iv, algorithm)
    cipher = OpenSSL::Cipher.new(algorithm)
    cipher.encrypt
    cipher.key = key
    cipher.iv = iv
    cipher
  end

  def self.encrypt_value(cipher, value)
    cipher.update(value) + cipher.final
  end

  def self.handle_encryption_error(e)
    if e.message == 'data not multiple of block length'
      raise 'Encryption failed: The input data is not a multiple of the block length.'
    else
      raise 'Encryption failed: #{e.message}'
    end
  end
end