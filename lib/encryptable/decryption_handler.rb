# frozen_string_literal: true

# standard:ignore Metrics/BlockLength

# decryption_handler.rb
# DecryptionHandler
module DecryptionHandler
  def self.decrypt(value, key, iv, algorithm)
    return if value.nil?
  
    decoded = decode_input(value)
  
    cipher = setup_cipher(key, iv, algorithm)
    decrypted_value = decrypt_value(cipher, decoded)
  
    decrypted_value
  rescue OpenSSL::Cipher::CipherError => e
    handle_decryption_error(e)
  rescue ArgumentError
    raise 'Decryption failed: The input data is not a valid Base64 encoded string.'
  end  

  private

  def self.decode_input(value)
    Base64.decode64(value.encode('ascii-8bit'))
  end

  def self.setup_cipher(key, iv, algorithm)
    cipher = OpenSSL::Cipher.new(algorithm)
    cipher.decrypt
    cipher.key = key
    cipher.iv = iv
    cipher
  end

  def self.decrypt_value(cipher, decoded)
    cipher.update(decoded) + cipher.final
  end

  def self.handle_decryption_error(e)
    if e.message == 'bad decrypt'
      raise 'Decryption failed: The provided key or IV might be incorrect.'
    elsif e.message.include?('wrong final block length')
      raise 'Decryption failed: The encrypted data might be corrupted.'
    else
      raise "Decryption failed: #{e.message}"
    end
  end
end
