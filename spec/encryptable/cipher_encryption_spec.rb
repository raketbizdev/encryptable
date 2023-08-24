# frozen_string_literal: true

# rspec ./spec/encryptable/cipher_encryption_spec.rb
require 'spec_helper'
require_relative '../../lib/encryptable/encryption_handler'
require_relative '../support/key_iv_helper'

RSpec.describe EncryptionHandler, '.encrypt' do
  include KeyIvHelper
  generated_key, generated_iv = generate_key_iv()
  let(:key) { generated_key }
  let(:iv) { generated_iv }
  let(:algorithm) { "AES-256-CBC" }
  let(:plaintext) { "Hello, world!" }
  let(:long_plaintext) { "This is a string that is not a multiple of the block length." }

  let(:decoded_key) { Base64.decode64(key) }
  let(:decoded_iv) { Base64.decode64(iv) }

  before(:all) do
    raise "Key length is not 32 bytes" unless decoded_key.bytesize == 32
    raise "IV length is not 16 bytes" unless decoded_iv.bytesize == 16
  end

  describe 'successful encryption' do
    it 'encrypts a given value' do
      encrypted_value = described_class.encrypt(plaintext, key, iv, algorithm)
      expect(encrypted_value).not_to eq(plaintext)
      expect(encrypted_value).to be_a(String)
    end
  end

  describe 'error handling' do
    context 'with a non-string value' do
      it 'raises an error' do
        expect {
          described_class.encrypt(12345, key, iv, algorithm)
        }.to raise_error('Encryption failed: The input value should be a string.')
      end
    end

    context 'with data not multiple of block length' do
      it 'raises an error' do
        expect {
          described_class.encrypt(long_plaintext, key, iv, algorithm)
        }.to raise_error('Encryption failed: The input data is not a multiple of the block length.')
      end
    end
  end
end

# rspec ./spec/encryptable/cipher_encryption_spec.rb