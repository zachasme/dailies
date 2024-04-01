class Letter
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_partial_path
    'letters/letter'
  end
end