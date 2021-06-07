#[2.10]真偽値と条件分岐ついてもっと詳しく

#[2.10.1]「&&」や「||」の戻り値と評価を終了するタイミング
#「&&」や「||」を使った場合、式全体の戻り値は必ずしもtrueまたはfalseになるとは限らない。

#全ての式を評価する必要があったため戻り値は「３」になる。
puts 1 && 2 && 3

#2つ目のnilを評価した時点で式全体の真偽値が偽であることが確定するのでそこで評価が終了してnilを返す。
puts 1 && nil && 3
puts 1 && false && 3

#「||」の場合でも同じ考え方で左辺から順に評価していく。
puts nil || false
puts false || nil
puts nil || false || 2 || 3

#if文のように「真または偽のどちらか」であればかまわないケースでは、戻り値に具体的に何であるか意識する必要はない！
#しかし、Rubyではif文以外のところで「&&」や「||」を意図的に使う場合がある。

#EX Alice,Bob,Carolと順に検索して最初に見つかったユーザー(nilまたはfalse以外の値)を変数に格納する。
user = find_user('alicec') || find_useer('Bob') || find_user('Carol')

#EX 正常なユーザーであればメールを送信する。(左辺が偽であればメール送信は実行されtない)
user.valid? && send_email_to(user)

#[2.10.2]優先順位が低い「and」,「or」,「not」
#「&&」,「||」,「!」に近い働きをする演算子として「and」,「or」,「not」がある。
#ただし、「and」,「or」,「not」は演算子の優先順位が低いため、「&&」,「||」,「!」と全く同じようには使うことはできない
優先順位
高い  !
     &&
     ||
     not
低い  and or

#EX 英語の論理演算子と記号の論理演算子を混在させたりすると結果が異なる
t1 = true
f1 = false
puts !t1 || t1
# => !(f1) || t1 の意味になる【「!」は「||」よりも優先順位が高い。】
puts not f1 || t1
# => not (f1 || t1)の意味になる【「not」は「||」よりも優先順位が低い。】

#「and」と「or」は優先順位に違いがないため「()」を使わない場合は左から右に順番に真偽値が評価される。
t1 = true
t2 = true
f1 = false

puts t1 || t2 && f1
# => true
# => 「&&」は「||」よりも優先順位が高い
# t1 || (t2 && f1)と同じ意味になる

puts t1 or t2 and f1
# => false
# => 「and」は「or」の優先順位は同じなので左から順に評価される
# (t1 or t2) and f1と同じ意味になる

#上記のような特徴があるため「and」や「or」を「&&」や「||」の代わりに使おうとすると思いがけない不具合を招く可能性があるので注意。

#「and」や「or」は条件分岐で使うのではなく、制御フローを扱うに向いている。

#EX 「正常なユーザーであればメールを送信する」という架空のコードからメソッド呼び出しの丸括弧を無くした場合
user.valid? && send_mail_to user
# => このままだと「構文エラー(SyntaxError)」になってしまう
# userに丸括弧を付けると処理が明確になるので構文エラーにはならない。
#以下のように解釈されてしまったために構文エラーが発生してしまっている
(user.valid? && send_mail_to) user
#ここで「and」を使うと次のように解釈されて構文エラーにはならない。
user.valid? and send_mail_to user == (user.valid?) and (send_mail_to user)

#EX 「or」も「Aか真か？真でなければBせよ」という制御フローを実現する際に便利
def greeting(country)
  #countryがnil(またはfalse)ならメッセージを返してメソッドを抜ける
  country or return 'countryを入力してください'

  if country == 'japan'
    puts 'こんにちは'
  else
    puts 'hello'
  end
end

puts greeting(nil)
puts greeting('japan')
puts greeting('italy')

#[2.10.3]unless文
#Rubyにはif文の反対の意味を持つ「unless」がある。
#何が反対かというと、条件式が偽になった場合にだけ処理を実行するという点で差異がある。

#EX if文で否定の条件を書いているときはunless文に書き換えられる。
  #if文
  status = 'error'
  if status != 'ok'
    puts '何か異常があります。'
  end

  #unless文へ書き換え
  status = 'error'
  unless status == 'ok'
    puts '何か異常があります。'
  end

  #elseを使って条件が正常だった場合の処理も書ける
  status = "error"
  unless status == 'ok'
    puts '何か異常があります。'
  else
    puts '正常です。'
  end
  # => ただし、if文の「elsif」に相当するものは存在しない！

#unlessはifと同様、unlessの戻り値を直接変数に代入したり、修飾子として文の後ろに置いたりできる。
#EX unlessの結果を変数に代入する
status = 'error'
message =
  unless status == 'ok'
    puts '何か異常があります。'
  else
    puts '正常です。'
  end

#EX unlessを修飾子として使う
status = 'error'
puts '何か異常があります。'unless status == "ok"

#thenを入れることができる点もif文と同じ
status = 'error'
unless status == 'ok' then
  puts '何か異常があります。'
end

#「if + 否定条件」は「unless + 肯定条件」に書き換えができるものの、必ずしも書き直さなければいけないわけではない。
#if文の方が読みやすいと思った場合は、「if + 否定条件」のままにして置いて大丈夫！
status = 'error'
if status != 'ok'
  puts '何か異常があります。'
end

#[2.10.4]case文
#複数の条件を指定する場合は、elsifを重ねるよりも「case文」で書いた方がシンプルになる。
case 対象のオブジェクトや式
when 値１
  #値１に一致する場合の処理
when 値２
  #値２に一致する場合の処理
when 値３
  #値３に一致する場合の処理
else
  #どれとも一致しない処理
end

#EX [2.5.3]if文の説明で使用したサンプルコードをcase文に書き換える
  #if文
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

  #case文
    country = 'italy'
    case country
    when 'japan'
      puts 'こんにちは'
    when 'us'
      puts 'Hello'
    when 'italy'
      puts 'ciao'
    else
      puts '???'
    end

#Rubyのcase文ではwhen節を使って複数の値を指定し、どれかに一致すれば処理を実行する、という条件分岐を書ける。
country = 'アメリカ'
case country
when 'japan', '日本'
  puts 'こんにちは'
when 'us', 'アメリカ'
  puts 'Hello'
when 'italy', 'イタリア'
  puts 'ciao'
else
  puts '???'
end

#if文と同様、case文も最後に評価された式を戻り値として返すため、case文の結果を変数に入れることが可能。
country = 'italy'
message =
  case country
  when 'japan'
    puts 'こんにちは'
  when 'us'
    puts 'Hello'
  when 'italy'
    puts 'ciao'
  else
    puts '???'
  end
  puts message

#when節の後ろにはthenを入れられ、when節とその条件が真だった場合の処理を1行で書くことができる。(使用頻度少なめ)
country = 'italy'
case country
when 'japan' then puts 'こんにちは'
when 'us' then puts 'Hello'
when 'italy' then puts 'ciao'
else puts '???'
end

#[2.10.5]条件演算子(三項演算子)
#RubyではC言語と同じような「?」を使った条件分岐(三項演算子)を使うことができる。
#EX [2.5.3]if文の説明で使用したサンプルコード
  n = 11
  if n > 10
    puts '10より大きい'
  else
    puts '10以下'
  end

  #条件演算子に書き換え
  n = 11
  n > 10 ? '10よりも大きい' : '10以下'

#シンプルなif/else文であれば、条件演算子を使った方がスッキリ書ける場合がある。逆に複雑な条件文だったりするとかえって読みづらくなってしまう場合があるので可動性を意識して使う必要がある。
