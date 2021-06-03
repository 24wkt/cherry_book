#[2.6]メソッドの定義
#Rudyは「def」を使ってメソッドを定義する。

def メソッド名(引数1,引数2)
  # 必要な処理
end

#ex 2つの数字を加算するメソッド
def add(a,b)
  a + b
end
puts add(1,2)

#メソッド名も変数名と同じルール。
#小文字のスネークケースで書き、アルファベットの小文字、またはアンダースコアで始め、アルファベット、数字、アンダースコアで構成する。
#アルファベット以外(ひらがな・漢字など)をメソッド名に使える点も同じ。

#ex メソッド名はスネークケースで書く
def hello_world
  'Hello, World'
end
puts hello_world

#ex キャラメルケースは使わない
def helloWorld
  'Hello, World'
end
puts hellowWorld
# ==> undefined local variable or method `hellowWorld' for main:Object (NameError)

#ex アンダースコアでメソッド名を書き始める(アンダースコアで始めることは少ない)
def _hello_world
  'Hello, World'
end
puts _hello_world

#ex メソッド名に数字を入れる
def hello_world_2
  'Hello, World'
end
puts hello_world_2

#ex 数字から始まるメソッド名は使えない（エラーになる）
def 2_hello_world
  'Hello, World'
end
puts 2_hello_world
# ==> syntax error, unexpected tINTEGER

#ex メソッド名をひらがなにする（一般的ではない）
def あいさつする
  'はろー、わーるど'
end
puts あいさつする

#[2.6.1]メソッドの戻り値
#戻り値に関する情報はメソッド定義に出てこない。(def int add(a,b)のように戻り値の型情報を書いたりすることはない)
#Rubyは最後に評価された式がメソッドの戻り値になるのが特徴。
#「return」のようなキーワードは不要。主に「return」を使わない書き方が主流ですが、使う場面もある(後述)。

#ex 「return」をあえて使う場合
def add (a,b)
  #returnも使えるが、使わないのが主流
  return a + b
end
puts add(1,2)

#ex 「return」を使わないRuby的な書き方
def greeting(country)
  #"こんにちは"または"hello"がメソッドの戻り値になる
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
puts greeting('japan')
puts greeting('us')

#ex Rubyで「return」を使う場合 => 「return」はメソッドを途中で脱出する場合に使われることが多い。
def greeting(country)
  #countryがnilならメッセージを返してメソッドを抜ける
  #(nil?はオブジェクトがnilの場合にtrueを返すメソッド)
  return 'countryを入力してください' if country.nil?

  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
puts greeting(nil)
puts greeting('japan')

#[2.6.2]メソッド定義における引数の()
#引数のないメソッドであれば、次のように()ごと省略してメソッドを定義する。
#ex => 引数がない場合は()を付けない方が主流
def greeting
  'こんにちは'
end
puts greeting

#ex 引数がある場合でも()は省略することができる => 引数がある場合は()をつけることが多い
def greeting country
  if country == 'japan'
    'こんにちは'
  else
    'Hello'
  end
end
puts greeting 'japan'