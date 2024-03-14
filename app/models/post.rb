class Post < ApplicationRecord
  belongs_to :company, optional: true
  has_many :post_stacks, dependent: :destroy
  has_many :stacks, through: :post_stacks
  belongs_to :user
  has_rich_text :comment

  enum status: {
    "en attente": 0,
    candidaté: 10,
    entretien: 20,
    refusé: 30
  }

  def color
    case status
    when "en attente"
      "#eab308"
    when "candidaté"
      "#38a169"
    when "entretien"
      "#94C1EA"
    when "refusé"
      "#e53e3e"
    end
  end

  enum scrap_status: {
    initializing: 0,
    ongoing: 10,
    failed: 20,
    successful: 30
  }

  validates :url, presence: true, uniqueness: true, on: :create
end
