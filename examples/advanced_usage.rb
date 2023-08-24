# Advanced Usage of the Encryptable Gem

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "encryptable"

# Configuration

new_key = "4oUYHawiAdtCb0mqFndKCZce44PRQ/2+3Tx9iCFUODw="
new_iv = "4cSIjYL2YBZsz84kjme0+Q=="

Encryptable.configure do |config|
  config.key = new_key
  config.iv = new_iv
end

# Custom Configuration for One-time Use
# I'm using the same key and IV for this example, but in a real scenario, you might want different values.
custom_cipher = Encryptable::Cipher.new(key: new_key, iv: new_iv)

# Encryption with Custom Configuration
plaintext = "Advanced Encryption"
encrypted_text = custom_cipher.encrypt(plaintext)
puts "Encrypted Text with Custom Configuration: #{encrypted_text}"

# Decryption with Custom Configuration
decrypted_text = custom_cipher.decrypt(encrypted_text)
puts "Decrypted Text with Custom Configuration: #{decrypted_text}"
