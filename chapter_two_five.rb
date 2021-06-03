#[2.5]真偽値と条件分岐
#[2.5.1]Rubyの真偽値
#Rubyの真偽値のルール
# (1)falseまたはnilであれば偽　(2)それ以外はすべて真

#ex データがあればそのデータを、データがなければnilを返すfind_dataという架空のメソッド
data = 100
if data != nil
  puts 'データがあります'
else
  puts 'データはありません'
end

#Rubyの場合だとfalseとnil以外はすべて真間ので、次のようにシンプルに書ける。
data = 100
if data
  puts 'データがあります'
else
  puts 'データがありません'
end
#Rubyプログラミングでは「nilも偽」という性質を活かしたコードがよく出てくるので、上記のようなコードにも早く慣れるようにしよう。

#[2.5.2]論理演算子
#「&&」や「||」のような論理演算子を使うと、複数の条件を１つにまとめることができる。

#条件1も条件2も真であれば真、それ以外は偽
#条件1 && 条件2 => 「条件1かつ条件2」の意味で、条件1も条件2も真であれば真になる。
t1 = true
t2 = true
f1 = false
puts t1 && t2
puts t1 && f1

#条件1か条件2のいずれかが真であれば真、両方が偽であれば偽
#条件1 || 条件2 => 「条件1または条件2」の意味で、条件1か条件2のいずれかが真であれば真になる。
t1 = true
f1 = false
f2 = false
puts t1 || f1
puts f1 || f2

#これらを組み合わせて使うこともできる。
#ただし、優先順位があり、「&&」の方が「||」よりも優先されるため、次の式は「条件１かつ条件２が真、または条件３かつ条件４が真なら真」の意味になる。
#条件１ && 条件２ || 条件３ && 条件４ == (条件１ && 条件２) || (条件３ && 条件４)
t1 = true
t2 = true
f1 = false
f2 = false
puts t1 && t2 || f1 && f2

#優先順位を変えたい場合は「()」を用いる。
#条件１ && (条件２ || 条件３) && 条件４ => 「条件１が真かつ、条件２または条件３が真かつ、条件４が真なら真」の意味。
t1 = true
t2 = true
f1 = false
f2 = false
puts t1 && (t2 || f1) && f2

#!演算子を使うと真偽値を反転することができる。つまり、真が偽に、偽が真になる。
t1 = true
f1 = false
puts !t1
puts !f1

#()を組み合わせると、()の中の真偽値を反転させることができる。
t1 = true
f1 = false
puts t1 && f1
puts !(t1 && f1)

#[2.5.3]if文
#条件分岐で一番よく使われるものはif文。
if 条件A
  # 条件Aが真だった場合の処理
elsif 条件B
  # 条件Bが真だった場合の処理
elsif 条件C
  # 条件Cが真だった場合の処理
else
  # それ以外の条件の処理
end

#条件を複数指定する場合は「elsif」を使う。また「elsif」や「else」が不要なら省略可能。
if 条件A
  #条件Aが真だった場合の処理
end

#ex 与えられた数値が10より大きいかどうかで処理を変える
n = 11
if n > 10
  puts '10より大きい'
else
  puts '10以下'
end

#ex 国によって挨拶を変える処理
country = 'italy'
if country == 'japan'
  puts 'こんにちは'
elsif country == 'us'
  puts 'Hello'
elsif country == 'italy'
  puts 'ciao'
else
  puts '???'
end
#今回は「puts」で文言を出力したが、Rubyのif文は最後に評価された式を戻り値として返す。
#「if文が戻り値を返す」という性質を利用して、次のようなif文の戻り値を変数に代入できる。
country = 'italy'
#if文の戻り値を変数に代入する
greeting =
  if country == 'japan'
    puts 'こんにちは'
  elsif country == 'us'
    puts 'Hello'
  elsif country == 'italy'
    puts 'ciao'
  end
  #戻り値が入ったもの
  puts greeting
#Rubyのif文が修飾子として文の後ろに置くことができる。if修飾子は後置ifと呼ばれることもある。

#ex 毎月１日だけポイント５倍にしたい場合のコード(普通にif文を書く場合)
point = 7
day = 1
# １日であればポイント５倍
if day == 1
  point *= 5
end
#戻り値が入ったもの
puts point

#「if」と「elsif」の後ろには「then」を入れると次の条件式とその条件が真だった場合の処理を１行に押し込めることができる。
# ==> しかし、使用頻度はあまり高くない。
if 条件A then
  # 条件Aが真だった場合の処理
elsif 条件B then
  # 条件Bが真だった場合の処理
else
  #それ以外の条件の処理
end

#ex １行に押し込める
country = 'italy'
if country == 'japan' then puts 'こんにちは'
elsif country == 'us' then puts 'Hello'
elsif country == 'italy' then puts 'ciao'
else puts'???'
end
#Rubyの条件分岐には、if文以外にも「unless」や「case」,「when」がある。（これらの機能については後述。）