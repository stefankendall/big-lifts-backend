module UsernameGenerator
  def self.generate
    "guest#{Time.now.to_i}#{rand(999)}"
  end
end