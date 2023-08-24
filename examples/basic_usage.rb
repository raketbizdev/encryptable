# Basic Usage of the Encryptable Gem

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "encryptable"
require "base64"

# Configuration
Encryptable.configure do |config|
  config.key = "4oUYHawiAdtCb0mqFndKCZce44PRQ/2+3Tx9iCFUODw="
  config.iv = "4cSIjYL2YBZsz84kjme0+Q=="
end

# Encryption
plaintext = "Ruel Nopal"
encrypted_text = Encryptable.cipher.encrypt(plaintext)
puts "Encrypted Text: #{encrypted_text}"

# Decryption
decrypted_text = Encryptable.cipher.decrypt(encrypted_text)
puts "Decrypted Text: #{decrypted_text}"