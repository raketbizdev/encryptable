# frozen_string_literal: true

# standard:ignore Metrics/BlockLength

require 'spec_helper'
require_relative '../../lib/encryptable/cipher'

RSpec.describe Encryptable::Cipher, '#decryption' do
  let(:valid_key) { Base64.strict_encode64('a' * 32) }
  let(:valid_iv) { Base64.strict_encode64('a' * 16) }
  subject(:cipher) { described_class.new(key: valid_key, iv: valid_iv) }

  it 'decrypts an encrypted value back to its original form' do
    encrypted_value = cipher.encrypt('plaintext')
    decrypted_value = cipher.decrypt(encrypted_value)
    expect(decrypted_value).to eq('plaintext')
  end
end
