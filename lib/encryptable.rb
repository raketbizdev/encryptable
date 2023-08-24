require "encryptable/cipher"
require "encryptable/configuration"

module Encryptable
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.cipher
    Cipher.new(
      key: configuration.key,
      iv: configuration.iv
    )
  end
end
