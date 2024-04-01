class Guess < ApplicationRecord
  belongs_to :user

  scope :today, -> { where(guessed_on: Date.current) }
  attribute :guessed_on, default: -> { Time.current }
  
  normalizes :word, with: -> word { word.strip.upcase }  
  validates :word, inclusion: { in: ALLOWED_WORDS }

  def word_of_the_day
    "ISBIL"
  end

  def letters
    word.chars.map { |l| Letter.new(l) }
  end
end
