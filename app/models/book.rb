class Book < ActiveRecord::Base
  belongs_to :book_type
  belongs_to :status
  has_many :book_in_uses, :dependent => :destroy
  has_many :book_by_providers, :dependent => :destroy
  validates :book_type_id, presence: true
  validates :status_id, presence: true
end
