class Desire < ApplicationRecord
  has_many :categories_desires
  has_many :categories, through: :categories_desires

  validates :body, presence: true

  after_create_commit { broadcast_append_to "desires" }
  after_update_commit { broadcast_replace_to "desires" }
  after_destroy_commit { broadcast_remove_to "desires" }

  scope :prioritized, -> { order(priority: :desc) }

  def increment_priority!
    self.priority += 1
    save
  end
end
