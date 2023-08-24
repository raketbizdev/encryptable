# frozen_string_literal: true

# standard:ignore Metrics/BlockLength

# rspec ./spec/encryptable/cipher_decryption_spec.rb
require 'spec_helper'
require_relative '../../lib/encryptable/decryption_handler'
require_relative '../support/key_iv_helper'

RSpec.describe DecryptionHandler, '.decrypt' do
  include KeyIvHelper

  let(:generated_key_iv) { generate_key_iv() }
  let(:key) { generated_key_iv[0] }
  let(:iv) { generated_key_iv[1] }

  let(:algorithm) { "AES-256-CBC" }
  let(:plaintext) { "Hello, world!" }
  let(:encrypted_value) { encrypt_sample_value(plaintext, decoded_key, decoded_iv, algorithm) }

  let(:decoded_key) { Base64.decode64(key) }
  let(:decoded_iv) { Base64.decode64(iv) }

  describe 'successful decryption' do
    it 'decrypts an encrypted value' do
      decrypted_value = described_class.decrypt(encrypted_value, decoded_key, decoded_iv, algorithm)
      expect(decrypted_value).to eq(plaintext)
    end
  end

  describe 'Key and IV lengths' do
    it 'validates the length of the key' do
      expect(decoded_key.bytesize).to eq(32)
    end

    it 'validates the length of the IV' do
      expect(decoded_iv.bytesize).to eq(16)
    end
  end

  describe 'error handling' do
    context 'with an invalid Base64 encoded string' do
      it 'raises an error' do
        expect {
          described_class.decrypt("invalid_base64", decoded_key, decoded_iv, algorithm)
        }.to raise_error('Decryption failed: The input data is not a valid Base64 encoded string.')
      end
    end

    context 'with an incorrect key or IV' do
      # Modify the key slightly to make it "incorrect"
      let(:incorrect_key) { decoded_key[0..-2] + "0" }  # Change the last byte of the key
  
      it 'raises an error' do
        expect {
          described_class.decrypt(encrypted_value, incorrect_key, decoded_iv, algorithm)
        }.to raise_error('Decryption failed: The provided key or IV might be incorrect.')
      end
    end
  end

  def encrypt_sample_value(value, key, iv, algorithm)
    # Use OpenSSL directly to encrypt a sample value
    cipher = OpenSSL::Cipher.new(algorithm)
    cipher.encrypt
    cipher.key = key
    cipher.iv = iv
    encrypted_data = cipher.update(value) + cipher.final
    Base64.encode64(encrypted_data).encode('ascii-8bit')
  end
end
