# order_address.rb
class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :token, :order_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :token, presence: true
  end
  validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }
  validates :city, :addresses, :phone_number, presence: true

  def save
    # 購入情報を保存し、変数orderに代入する
    order = Order.create(item: Item.find(item_id), user: User.find(user_id))
    # order = Order.new(price: Price.find(item_id))

    # 住所を保存する
    address = Address.create(postal_code:, prefecture:, city:, addresses:,
                             building:, phone_number:, order_id:)
    # order_idには、変数orderのidと指定する
    order.address = address
    # order.save
  end
end