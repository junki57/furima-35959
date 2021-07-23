crumb :root do
  link "トップページ", root_path
end
crumb :new_item do
  link "商品出品ページ", new_item_path
  parent :root
end
crumb :show_item do
  link "商品詳細ページ", item_path
  parent :root
end
crumb :edit_item do
  link "商品編集ページ", edit_item_path
  parent :show_item
end
crumb :new_card do
  link "クレジットカード登録", new_card_path
  parent :root
end
crumb :my_user do
  link "マイページ", user_path
  parent :root
end
crumb :orders_item do
  link "商品購入ページ", item_orders_path
  parent :root
end
crumb :sign_up do
  link "新規登録", new_user_registration_path
  parent :root
end
crumb :sign_in do
  link "ログイン", new_user_session_path
  parent :root
end
