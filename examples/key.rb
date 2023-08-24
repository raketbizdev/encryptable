require "openssl"

def generate_key_iv(key_length: 32, iv_length: 16)
  key = OpenSSL::Random.random_bytes(key_length)
  iv = OpenSSL::Random.random_bytes(iv_length)

  # Convert them to base64 format (easier to store in environment variables)
  key_base64 = [key].pack("m0")
  iv_base64 = [iv].pack("m0")

  [key_base64, iv_base64]
end

# Default values
key_base64, iv_base64 = generate_key_iv
puts "Key (Default): #{key_base64}"
puts "IV (Default): #{iv_base64}"

# Example with custom values
# key_base64, iv_base64 = generate_key_iv(key_length: 24, iv_length: 12)
# puts "Key (Custom): #{key_base64}"
# puts "IV (Custom): #{iv_base64}"
