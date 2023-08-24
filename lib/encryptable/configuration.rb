module Encryptable
  class Configuration
    attr_accessor :key, :iv

    def initialize
      @key_length = 32
      @iv_length = 16
    end
  end
end
