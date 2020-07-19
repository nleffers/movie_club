class User < ApplicationRecord
  has_and_belongs_to_many :movies

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
