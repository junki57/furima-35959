class DonationAddress
  include ActiveModel::Model
  attr_accessor :user_id,:item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city
    validates :block
    validates :building
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end
  validates :prefecture_id, numericality: { other_than: 1 } 
  

  def save
    # 各テーブルにデータを保存する処理を書く
    purchase = Purchase.create(user: user, item: item)
    Residence.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, purchase_id: purchase.id )
  end
end