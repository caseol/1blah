class Favorite < ActiveRecord::Base
  belongs_to :users
  belongs_to :buttons

end
