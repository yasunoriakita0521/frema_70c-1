class User < ApplicationRecord
<<<<<<< HEAD
  has_many   :items , dependent: :destroy
  has_many   :comments , dependent: :destroy
  has_one   :addresses , dependent: :destroy
  has_one   :card , dependent: :destroyhas_many   :addresses , dependent: :destroy

devise :database_authenticatable, :registerable,
=======
  has_many   :items  , dependent: :destroy
  has_many   :addresses , dependent: :destroy

  devise :database_authenticatable, :registerable,
>>>>>>> origin
         :recoverable, :rememberable, :validatable

  validates :firstname , :lastname, :firstname_kana, :lastname_kana, :nickname, :birth_year, :birth_month, :birth_day, :tel_number, presence: true
  validates :tel_number, uniqueness: true

  validates :firstname     , format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :lastname      , format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :firstname_kana, format: {with: /\A[ァ-ンー－]+\z/}
  validates :lastname_kana , format: {with: /\A[ァ-ンー－]+\z/}
  validates :birth_year    , format: {with: /\A\d{4}\z/}
  validates :birth_month   , numericality: { only_integer: true , greater_than: 0, less_than: 13 }
  validates :birth_day     , numericality: { only_integer: true , greater_than: 0, less_than: 32 }
  validates :tel_number    , numericality: { only_integer: true }, length: { in: 10..11 }
<<<<<<< HEAD
end
=======
end
>>>>>>> origin
