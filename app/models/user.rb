class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :nickname

  validates_presence_of :email, :nickname, :password, :password_confirmation
  validates_uniqueness_of :email, :nickname

  has_secure_password

  has_many :buttons
  has_many :favorites

  scope :ranking_publicadores, {
       :select=> " users.nickname, count(buttons.user_id) as rank",
       :joins=> "JOIN buttons ON (buttons.user_id = users.id) ",
       :group=> "users.id",
       :order=> "rank DESC"
  }

  scope :ranking_tocadores, {
       :select=> " users.nickname, SUM(counts.value) as total_toques",
       :joins=> "JOIN buttons ON (buttons.user_id = users.id) JOIN counts ON (counts.button_id = buttons.id)",
       :group=> "users.id",
       :order=> "total_toques DESC"
  }

  scope :ranking_media_toques, {
         :select=> " users.nickname, (SUM(counts.value)/count(buttons.id)) as media",
         :joins=> "JOIN buttons ON (buttons.user_id = users.id) JOIN counts ON (counts.button_id = buttons.id)",
         :group=> "users.id",
         :order=> "media DESC"
    }

  def is_favorite(button_id)
    !self.favorites.find_by_button_id(button_id).nil?
  end


end
