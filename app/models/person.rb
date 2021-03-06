class Person < ActiveRecord::Base
  has_and_belongs_to_many :posts
  belongs_to :user

  def self.search(query)
    where("name like ?", "%#{query}%")
  end
end
