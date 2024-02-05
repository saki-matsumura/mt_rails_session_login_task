class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  scope :user_tasks, -> (query){ where(" tasks.user_id = ? ", query) }

end
