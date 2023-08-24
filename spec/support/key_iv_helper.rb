# spec/support/key_iv_helper.rb

module KeyIvHelper
  def generate_key_iv(key_length: 32, iv_length: 16)
    key = OpenSSL::Random.random_bytes(key_length)
    iv = OpenSSL::Random.random_bytes(iv_length)

    # Convert them to base64 format (easier to store in environment variables)
    key_base64 = [key].pack("m0")
    iv_base64 = [iv].pack("m0")

    [key_base64, iv_base64]
  end
end