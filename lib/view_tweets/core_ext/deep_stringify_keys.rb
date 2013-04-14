require "active_support/core_ext/hash/keys"

# Nicked from https://github.com/rails/rails/blob/541429fbe49b0671adb3842ab1818230d670ef9f/activesupport/lib/active_support/core_ext/hash/keys.rb
class Hash
  def deep_stringify_keys
    result = {}
    each do |key, value|
      result[key.to_s] = value.is_a?(Hash) ? value.deep_stringify_keys : value
    end
    result
  end
end
