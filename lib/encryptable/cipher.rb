# frozen_string_literal: true

# standard:ignore Metrics/BlockLength

require 'openssl'
require 'base64'
require 'digest'
require_relative 'encryption_handler'
require_relative 'decryption_handler'

module Encryptable
  # This class handles encryption and decryption using AES-256-CBC algorithm.
  class Cipher
    ALGORITHM = 'AES-256-CBC'

    def initialize(key:, iv:)
      validate_string_inputs!(key, iv)
      decode_key_and_iv!(key, iv)
      validate_lengths!
      derive_key_and_iv!
    end

    def encrypt(value)
      EncryptionHandler.encrypt(value, @key, @iv, ALGORITHM)
    end

    def decrypt(value)
      DecryptionHandler.decrypt(value, @key, @iv, ALGORITHM)
    end

    private

    def validate_string_inputs!(key, iv)
      raise 'Initialization failed: Key and IV should be strings.' unless key.is_a?(String) && iv.is_a?(String)
    end

    def decode_key_and_iv!(key, iv)
      @original_key = Base64.decode64(key)
      @original_iv = Base64.decode64(iv)
    rescue ArgumentError
      raise 'Initialization failed: Key or IV is not a valid Base64 encoded string.'
    end

    def derive_key_and_iv!
      @key = derive_key(@original_key, 32)
      @iv = derive_key(@original_iv, 16)
    end

    def validate_lengths!
      if @original_key.bytesize < 32
        raise ArgumentError, 'Key length is below the minimum required (32 bytes).'
      elsif @original_key.bytesize > 32
        raise ArgumentError, 'Key length exceeds the maximum allowed (32 bytes).'
      end

      if @original_iv.bytesize < 16
        raise ArgumentError, 'IV length is below the minimum required (16 bytes).'
      elsif @original_iv.bytesize > 16
        raise ArgumentError, 'IV length exceeds the maximum allowed (16 bytes).'
      end
    end

    def derive_key(input, desired_length)
      hashed = OpenSSL::Digest::SHA256.digest(input)
      hashed[0, desired_length]
    end
  end
end