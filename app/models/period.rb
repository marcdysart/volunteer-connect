class Period < ActiveRecord::Base
  has_and_belongs_to_many :posts

  def self.search_start(query)
    where("start like ?", "%#{query}%")
  end

  def self.search_end(query)
    where("end like ?", "%#{query}%")
  end
end
