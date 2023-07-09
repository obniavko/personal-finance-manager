class Category < ApplicationRecord
  before_destroy :destroy_operations
  has_many :operations

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def destroy_operations
    self.operations.destroy_all
  end

  paginates_per 10
end
