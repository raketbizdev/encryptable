# frozen_string_literal: true

# standard:ignore Metrics/BlockLength

require 'spec_helper'
require_relative '../../lib/encryptable/cipher'

RSpec.describe Encryptable::Cipher, '#encryption' do
  let(:valid_key) { Base64.strict_encode64('a' * 32) }
  let(:valid_iv) { Base64.strict_encode64('a' * 16) }
  subject(:cipher) { described_class.new(key: valid_key, iv: valid_iv) }

  it 'encrypts a given value' do
    encrypted_value = cipher.encrypt('plaintext')
    expect(encrypted_value).not_to eq('plaintext')
    expect(encrypted_value).not_to be_nil
  end

  it 'raises an error if the input value is not a string' do
    expect do
      cipher.encrypt(12_345)
    end.to raise_error('Encryption failed: The input value should be a string.')
  end
end

# Run
# rspec spec/encryptable/cipher_initialization_spec.rb