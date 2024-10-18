class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :article

  enum role: { owner: 0, co_author: 1 }
end
