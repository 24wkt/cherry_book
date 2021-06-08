#[2.11]メソッド定義についてもっと詳しく
#[2.11.1]デフォルト値付きの引数
#Rubyメソッドを呼び出す際に引数の過不足があるとエラーになる
def greeting(country)
  if country == 'japan'
    puts 'こんにちは'
  else
    'hello'
  end
end

#引数が少ない
puts greeting
# ==> (ArgumentError) wrong number of arguments (given 0, expected 1)

#引数がちょうど
puts greeting('us')
# ==> hello

#引数が多い
puts greeting('us', 'japan')
 # ==> (ArgumentError) wrong number of arguments (given 2, expected 1)

 #ただし、Rubyではメソッドの引数の数を柔軟に変える方法がいくつかある。
 #そのうちの一つが「デフォルト値付きの引数」

def メソッド(引数１ = デフォルト値１, 引数２ = デフォルト値２)
  # 必要な処理
end

#EX 上記のgreetingメソッドにデフォルト値を設定してみる
  def greeting(country = 'japan')
    if country == 'japan'
      puts 'こんにちは'
    else
      'hello'
    end
  end

  puts greeting
  # ==> こんにちは
  puts greeting('us')
  # ==> hello

#デフォルト値付きの引数を使う場合は、デフォルト値ありとデフォルト値なしの引数を混在させることもできる。
def defaul_args(a, b, c = 0, d = 0)
  puts "a=#{a}", "b=#{b}", "c=#{c}", "d=#{d}"
end

puts defaul_args(1,2)
# ==> a=1, b=2, c=0, d=0
puts defaul_args(1,2,3)
# ==> a=1, b=2, c=3, d=0
puts defaul_args(1,2,3,4)
# ==> a=1, b=2, c=3, d=4

#また、デフォルト値は固定の値だけでなく、動的に変わる値や他のメソッドの戻り値を指定できる。
def bar
  'BAR'
end

def foo(time = Time.now, message = bar)
  puts "time: #{time}, message: #{message}"
end

puts foo
# ==> time: 2021-06-08 10:54:02 +0900, message: BAR

#[2.11.2]「?」で終わるメソッド
#Rudyのメソッド名は「?」や「!」で終わらせることができる。
#「?」で終わるメソッドは慣習として「真偽値を返すメソッド」になっている！

#EX 空文字であればtrue、そうでなければfalse
  puts ''.empty?    # ==> true
  puts 'abc'.empty? # ==> false

#EX 引数の文字列が含まれていればtrue、そうでなければfalse
  puts 'watch'.include?('at') # ==> true
  puts 'watch'.include?('in') # ==> false

#EX 奇数ならtrue、偶数ならfalse
  puts 1.odd? # ==> true
  puts 2.odd? # ==> false

#EX 偶数ならtrue、奇数ならfalse
  puts 1.even? # ==> false
  puts 2.even? # ==> true

#EX オブジェクトがnilであればtrue、そうでなければfalse
  puts nil.nil?   # ==> true
  puts 'abc'.nil? # ==> false
  puts 1.nil?     # ==> false

#「?」で終わるメソッドは自分で定義することもできる。
#真偽値を返す目的のメソッドであればm「?」で終わらせるようにしたほうが良い！

#EX 3の倍数ならtrue、それ以外はfalseを返す
  def multiple_of_three?(n)
    n % 3 == 0
  end
  puts multiple_of_three?(4) # ==> false
  puts multiple_of_three?(5) # ==> false
  puts multiple_of_three?(6) # ==> true

#[2.11.3]「!」で終わるメソッド
#「!」で終わるメソッドは慣習として「使用する際は注意が必要」という意味を持つ。

#「upceseメソッド」と「upcase!メソッド」という2つメソッドある。
#どちらも文字列を大文字にするメソッドですが、upcaseメソッドは大文字変えた新しい文字列を返し、呼び出した文字列自身は変化しない。
#それに対し、upcase!メソッドは呼び出した文字列自身を大文字に変更する。

#EX 「upcase」だと変数aの値は変化しない
  a = 'ruby'
  puts a.upcase # ==> RUBY :大文字に変えた「新しい文字列」を返す！
  puts a        # ==> ruby :呼び出した文字列自体は変化しない！

#EX 「upcase!」だと変数aの値も大文字に変わる
  a = 'ruby'
  puts a.upcase! # ==> RUBY
  puts a         # ==> RUBY

#「upcase!メソッド」のように、呼び出したオブジェクトの状態を変更してしまうメソッドのことを「破滅的メソッド」と呼ぶ。
#「!」で終わるメソッドは「?」で終わるメソッドほど慣習が明確ではない。破滅的メソッドが全て！で終わるかと言えばそうではない。
#破滅的メソッドでないメソッド(不正な状態で呼び出すとエラーを発生させるメソッドなど)に！をつける時もある。
#いずれにしても！で終わるメソッドには何かしらの注意事項があるはずなので、APIドキュメントなどを読んで確認することを習慣付けよう。

#「!」も「?」同様、自分でメソッドを定義することができる。
#EX 引数として渡した文字列を逆順に並び替え、さらに大文字に変更する破滅的メソッド
  def reverse_upcase!(s)
    puts s.reverse.upcase!
  end
  
  s = 'ruby'
  puts reverse_upcase!(s)

#変数名には「!」や「?」で終わらせることができないので注意！
#EX 変数名につけるとエラーになる
  puts odd? = 1.odd?
  #syntax error, unexpected '='
  #puts odd? = 1.odd?
  #
            ^
  
  puts upcase! = 'ruby'.upcase!
  #syntax error, unexpected '='
  #puts upcase! = 'ruby'.upcase!
  #             ^