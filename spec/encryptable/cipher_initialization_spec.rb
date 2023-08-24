# frozen_string_literal: true

# standard:ignore Metrics/BlockLength
# rspec spec/encryptable/cipher_initialization_spec.rb

require 'spec_helper'
require_relative '../../lib/encryptable/cipher'

RSpec.describe Encryptable::Cipher, '#initialization' do
  let(:valid_key) { Base64.strict_encode64('a' * 32) }
  let(:valid_iv) { Base64.strict_encode64('a' * 16) }

  context 'when given invalid inputs' do
    it 'raises an error if key or IV is not a string' do
      expect { described_class.new(key: 12345, iv: valid_iv) }
        .to raise_error('Initialization failed: Key and IV should be strings.')
      
      expect { described_class.new(key: valid_key, iv: 12345) }
        .to raise_error('Initialization failed: Key and IV should be strings.')
    end

    it 'raises an error if key is less than 32 bytes' do
      short_key = Base64.strict_encode64('a' * 31)
      expect do
        described_class.new(key: short_key, iv: valid_iv)
      end.to raise_error(ArgumentError, 'Key length is below the minimum required (32 bytes).')    
    end

    it 'raises an error if IV is less than 16 bytes' do
      short_iv = Base64.strict_encode64('a' * 15)
      expect do
        described_class.new(key: valid_key, iv: short_iv)
      end.to raise_error(ArgumentError, 'IV length is below the minimum required (16 bytes).')    
    end

    # Add test for key and IV lengths greater than the limit
    it 'raises an error if key is more than 32 bytes' do
      long_key = Base64.strict_encode64('a' * 33)
      expect do
        described_class.new(key: long_key, iv: valid_iv)
      end.to raise_error(ArgumentError, 'Key length exceeds the maximum allowed (32 bytes).')
    end

    it 'raises an error if IV is more than 16 bytes' do
      long_iv = Base64.strict_encode64('a' * 17)
      expect do
        described_class.new(key: valid_key, iv: long_iv)
      end.to raise_error(ArgumentError, 'IV length exceeds the maximum allowed (16 bytes).')
    end
  end

  context 'when given valid inputs' do
    it 'successfully initializes the cipher' do
      expect { described_class.new(key: valid_key, iv: valid_iv) }.not_to raise_error
    end
  end
end
