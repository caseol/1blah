class Category < ActiveRecord::Base
  has_many :buttons

  def to_param
    "#{id}-#{name}"
  end
end
