require 'openssl'
require 'base64'

module Encryptable
  class Cipher
    ALGORITHM = 'AES-256-CBC'

    attr_reader :key, :iv

    def initialize(key:, iv:)
      @key = key
      @iv = iv
    end

    def encrypt(value)
      return if value.nil?

      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.encrypt
      cipher.key = key
      cipher.iv = iv
      encrypted = cipher.update(value) + cipher.final

      Base64.encode64(encrypted).encode('utf-8')
    end

    def decrypt(value)
      return if value.nil?

      decoded = Base64.decode64(value.encode('ascii-8bit'))

      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.decrypt
      cipher.key = key
      cipher.iv = iv
      cipher.update(decoded) + cipher.final
    end
  end
end
