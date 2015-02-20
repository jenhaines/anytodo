class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  after_initialize :defaults

  def self.private
    List.where permissions: "private"
  end

  def self.viewable
    List.where permissions: "viewable"
  end

  def self.open
    List.where permissions: "open"
  end

  def self.permission_options
    %w(private viewable open)
  end

  def self.all_available(user)
    List.where( user_id: user.id || self.open) 
  end

  def add(item_description)
    if items.create(description: item_description)
      true
    else
      false
    end
  end

  def remove(item_description)
    if item = items.find_by(description: item_description)
      item.mark_complete
    else
      false
    end
  end

  def defaults
    self.permissions ||= 'private'
  end
  
end
