module Encryptable
  class Configuration
    attr_accessor :key, :iv

    def initialize
      @key = nil
      @iv = nil
    end
  end
end