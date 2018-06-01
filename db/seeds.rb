# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Category

Category.destroy_all #先清空資料表,才不會在重複載入種子資料時,網站出現重複的分類

category_list = [
  { name: "中式料理" },
  { name: "日本料理" },
  { name: "義大利料理" },
  { name: "墨西哥料理" },
  { name: "素食料理" },
  { name: "美式料理" },
  { name: "複合式料理" }
]

category_list.each do |category|
  Category.create( name: category[:name] )
end
puts "Category created!"


# Default admin
# 建立一個預設的admin帳號

User.create(name: "admin", email: "admin@sample.com", password: "sample", role: "admin")
puts "Default admin created!"
