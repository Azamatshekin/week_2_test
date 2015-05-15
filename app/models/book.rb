class Book < ActiveRecord::Base
  belongs_to :book_type
  belongs_to :status
  has_many :book_in_uses, :dependent => :destroy
  has_many :book_by_providers, :dependent => :destroy
  validates :book_type_id, presence: true
  validates :status_id, presence: true
  validates :barcode, presence: true, length: {maximum: 80, minimum: 2},
            uniqueness: { case_sensitive: false }

  def self.search(search)
    if search
      self.joins(:book_type).where("barcode like ? or book_types.name like ? or book_types.author like ?",
                                   "%#{search}%", "%#{search}%", "%#{search}%")
    else
      self.all
    end
  end
  def self.search_lost(search)
    if search
      self.joins(:book_type).where("(barcode like ? or book_types.name like ? or book_types.author like ?) and status_id=3",
                                   "%#{search}%", "%#{search}%", "%#{search}%")
    else
      self.where("status_id=3")
    end
  end
end
