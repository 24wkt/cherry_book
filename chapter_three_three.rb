#[3.3]FizzBuzzプログラムのテスト自動化
#[3.3.1]putsメソッドをテストコードに置き換える
#第２章で作成した「fizz_buzz.rb」を開いて以下の状態にするに書き換える！

def fizz_buzz(n)
  if n % 15 == 0
    'FizzBuzz'
  elsif n % 3 == 0
    'Fizz'
  elsif n % 5 == 0
    'Buzz'
  else
    n.to_s
  end
end

require 'minitest/autorun'

class FizzBuzzTest < Minitest::Test
  def test_fizz_buzz
    assert_equal '1', fizz_buzz(1)
    assert_equal '2', fizz_buzz(2)
    assert_equal 'Fizz', fizz_buzz(3)
  end
end

#puts fizz_buzz(1)
#puts fizz_buzz(2)
#puts fizz_buzz(3)
#puts fizz_buzz(4)
#puts fizz_buzz(5)
#puts fizz_buzz(6)
#puts fizz_buzz(15)

# !-- ファイルの実行時は別ファイルので実行 --!

#テストが正しく実行されたら他の数値も全部テスト数値内で検証されるようにテストを追加しましょう。
#正しかった場合は以下のようになる。

Run options: --seed 36280

# Running:

.

Finished in 0.000578s, 1730.1039 runs/s, 5190.3116 assertions/s.

1 runs, 3 assertions, 0 failures, 0 errors, 0 skips

#追加した場合のコードは以下の通り
def fizz_buzz(n)
  if n % 15 == 0
    'FizzBuzz'
  elsif n % 3 == 0
    'Fizz'
  elsif n % 5 == 0
    'Buzz'
  else
    n.to_s
  end
end

require 'minitest/autorun'

class FizzBuzzTest < Minitest::Test
  def test_fizz_buzz
    assert_equal '1', fizz_buzz(1)
    assert_equal '2', fizz_buzz(2)
    assert_equal 'Fizz', fizz_buzz(3)
    assert_equal '4', fizz_buzz(4)
    assert_equal 'Buzz', fizz_buzz(5)
    assert_equal 'Fizz', fizz_buzz(6)
    assert_equal 'FizzBuzz', fizz_buzz(15)
  end
end

#puts fizz_buzz(1)
#puts fizz_buzz(2)
#puts fizz_buzz(3)
#puts fizz_buzz(4)
#puts fizz_buzz(5)
#puts fizz_buzz(6)
#puts fizz_buzz(15)

#正常にテストが実行された場合は以下のようになります。

Run options: --seed 13072

# Running:

.

Finished in 0.000563s, 1776.1990 runs/s, 12433.3930 assertions/s.

1 runs, 7 assertions, 0 failures, 0 errors, 0 skips

#試しにわざとテストを失敗させて、ちゃんと問題を検知できるか確認してみましょう。
# EX 引数を15から16に変更する

def fizz_buzz(n)
  if n % 15 == 0
    'FizzBuzz'
  elsif n % 3 == 0
    'Fizz'
  elsif n % 5 == 0
    'Buzz'
  else
    n.to_s
  end
end

require 'minitest/autorun'

class FizzBuzzTest < Minitest::Test
  def test_fizz_buzz
    assert_equal '1', fizz_buzz(1)
    assert_equal '2', fizz_buzz(2)
    assert_equal 'Fizz', fizz_buzz(3)
    assert_equal '4', fizz_buzz(4)
    assert_equal 'Buzz', fizz_buzz(5)
    assert_equal 'Fizz', fizz_buzz(6)
    assert_equal 'FizzBuzz', fizz_buzz(16)
  end
end

#puts fizz_buzz(1)
#puts fizz_buzz(2)
#puts fizz_buzz(3)
#puts fizz_buzz(4)
#puts fizz_buzz(5)
#puts fizz_buzz(6)
#puts fizz_buzz(15)

#ちゃんとテストが失敗した場合は以下のように表示されます。

Run options: --seed 20356

# Running:

F

Finished in 0.008208s, 121.8324 runs/s, 852.8265 assertions/s.

  1) Failure:
FizzBuzzTest#test_fizz_buzz [/Users/ryotaono/Documents/programming/cherry_book/tempCodeRunnerFile.rb:23]:
--- expected
+++ actual
@@ -1,2 +1 @@
-# encoding: UTF-8
-"FizzBuzz"
+"16"


1 runs, 7 assertions, 1 failures, 0 errors, 0 skips

# ==> 「-FizzBuzz」が期待した結果で「+"16"」が実際の結果です。
#      なので値が異なっているよ、と表示されています。

#[3.3.2]プログラムと本体を分離する
#今の状態だとテスト対象のプログラムとテストコードが1つのファイルに結合してしまっています。
#本来であればプログラム本体とテストコードは分離して別々のファイルとして管理すべきです。

#テストコードを分離してテストを実行するといかのようになります。

# 〜〜省略〜〜

1) Error:
FizzBuzzTest#test_fizz_buzz:
NoMethodError: undefined method `fizz_buzz' for #<FizzBuzzTest:0x00007f9e49886a00>
    /Users/ryotaono/Documents/programming/cherry_book/tempCodeRunnerFile.rb:5:in `test_fizz_buzz'

1 runs, 0 assertions, 0 failures, 1 errors, 0 skips

# ==> 「NoMethodError: undefined method `fizz_buzz'」と定義されていないメソッドが呼び出されている。
#      つまり、分離したもとのFizzBuzz.rbを見つけられていないのです。


#他のファイルを読み込むときは「requireメソッド」を用いることでそのファイルに任意のファイルを参照させることができます。
#テストコードに「require '読み込ませたいファイルの場所'」を付け足して実行してみましょう！