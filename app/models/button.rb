class Button < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_one :count
  has_many :favorites

  has_attached_file :media

  validates_presence_of :category_id
  validates_presence_of :title
  validates_attachment_presence :media, :message => I18n.t("paperclip.errors.media_presence")

  #validates_attachment_content_type :media, :content_type => ['audio/mp3', 'application/x-mp3'], :if => :media_attached?
  validates_format_of :media_file_name, :with => %r{\.(mp3)$}i, :message => I18n.t("paperclip.errors.media_format"), :if => :media_attached?
  validates_attachment_size :media, :less_than => 1.megabytes, :if => :media_attached?

  self.per_page = 28

  # Escopos
  scope :favoritos, lambda{|user_id| {
     :select=> "DISTINCT buttons.*",
     :joins=> "JOIN favorites ON (favorites.button_id = buttons.id) JOIN counts ON (counts.button_id = buttons.id) ",
     :conditions=> "favorites.user_id = #{user_id}",
     :order=> "counts.value DESC"
    }
  }

  scope :por_mais_tocados, lambda{ |order|
    joins("JOIN counts ON (counts.button_id = buttons.id) ").order("counts.value #{order}")
  }

  def get_msg
    I18n.t('activerecord.errors.messages.paperclip.size', :size=>1.megabyte)
  end

  def media_attached?
    self.media.file?
  end

  def is_favorite(user_id)
    !self.favorites.find_by_user_id(user_id).nil?
  end
end
