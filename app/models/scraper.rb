class Scraper < ApplicationRecord
  has_many :posts

  enum scrap_status: {
    pending: 0,
    ongoing: 10,
    failed: 20,
    successful: 30,
  }
end
