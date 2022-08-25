fruits_price = [["apple", [200, 250, 220]], ["orange", [100, 120, 80]], ["melon", [1200, 1500]]]

fruits_price .each do |fruits|
  # ["apple", [200, 250, 220]]  と  ["orange", [100, 120, 80]]  と  ["melon", [1200, 1500]]をそれぞれfruitsに入れる
  sum = 0
  fruits[1] .each do |price|
    # 値段の   200, 250, 220  をそれぞれprice に代入
    sum = sum + price
    # each内の sum = sum + priceっていうのは再代入を繰り返しているという認識なのか？
  end
  puts "#{fruits[0]}の合計金額は#{sum}円です"

end