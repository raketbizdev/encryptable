# frozen_string_literal: true

# rspec ./spec/encryptable/cipher_encryption_spec.rb
require 'spec_helper'
require_relative '../../lib/encryptable/encryption_handler'
require_relative '../support/key_iv_helper'

RSpec.describe EncryptionHandler, '.encrypt' do
  include KeyIvHelper

  let(:generated_key_iv) { generate_key_iv() }
  let(:key) { generated_key_iv[0] }
  let(:iv) { generated_key_iv[1] }
  let(:algorithm) { "AES-256-CBC" }
  let(:plaintext) { "Hello, world!" }
  let(:long_plaintext) { "This is a string that is not a multiple of the block length." }

  let(:decoded_key) { Base64.decode64(key) }
  let(:decoded_iv) { Base64.decode64(iv) }

  describe 'Key and IV lengths' do
    it 'validates the length of the key' do
      expect(decoded_key.bytesize).to eq(32)
    end

    it 'validates the length of the IV' do
      expect(decoded_iv.bytesize).to eq(16)
    end
  end

  describe 'successful encryption' do
    it 'encrypts a given value' do
      encrypted_value = described_class.encrypt(plaintext, decoded_key, decoded_iv, algorithm)
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
  end
end

