#[3.2]Minitestの基本
#テストの重要性を理解したところで、実際にどうやるのかを見ていきましょう！

#テストを自動化するにはテスト用のフレームワークを利用します。
#Rubyにはいくつかのテストフレームワークが存在しますが、今回はMinitestというフレームワークを利用します。
# ==> Minitestを選んだ理由
#    ①Rubyをインストールすると、一緒にインストールされるため、特別なセットアップがいらない。
#    ②学習コストが比較的低い。
#    ③Railsのデフォルトのテスティングフレームワークなので、Railsを開発するときにも知識を活かせる。

#テストの自動化というと何かすごいことをするように感じるかもしれませんが、実際はそれほど難しいものではありません。
#　==> 必要な手順は次の通り
#      ①テスティングフレームワークのルールに沿って、プログラムの実行結果を検証するRubyプログラム(テストコード)を書く。
#      ②上記①で作ったテストコードを実行する。
#      ③テスティングフレームワークが実行結果をチェックし、その結果が正しいか間違っているかを報告する。

#[3.2.1]テストコードの雛形
# EX Minitestを使ったテストコードの基本形
  require 'minitest/autorun'

  class SampleTest < Minitest::Test
    def test_sample
      assert_equal 'RUBY', 'ruby'.upcase
    end
  end

# ==> 19行目の「require 'minitest/autorun'」はライブラリを読み込んでプログラム内でMinitestを使えるようにするためのコードです。

# ==> 21行目の「class SampleTest < Minitest::Test」から25行目までの「end」までが、テストコードの本体(テストクラス)です。

# ==> 「SampleTest」はクラスの名前です。命名は自由ですが、慣習として「JapaneseCalendarTest」や「TestOrderItem」など、Testで終わるまたは始まる名前をつけることが多い。
#　　　 またファイル名は「japanese_calendar_test.rb」や「test_order_item.rb」のように、クラス名と合わせます。
#      クラスの名前は「キャラメルケース」、ファイルの名前は「スネークケース」で書きます！

# ==> 「< Minitest::Test」の部分は「SampleTestクラスがMinitest::Testクラスを継承する」ことを表している！（詳細は７章にて）

# ==> 22行目から24行目までが実行対象となるテストメソッドです。Minitestは「test_」で始まるメソッドを探して、それを実行します。
#     なので、メソッド名は「test_」で始めることが必須になります。
#     test_から後ろの部分は自由ですが、「test_item_name」や「test_send_mail」など、メソッド内でテストする内容が推測できるような名前をつけましょう！
#     なお、「test_」で始まるメソッドを複数定義しても構いません。Minitestはtest_で始まるメソッドを全て実行します。

# ==> 24行目「assert_equal 'RUBY', 'ruby'.upcase」が実行結果するための検証メソッドです。
#     ここではMinitestが提供する「assert_equalメソッド」を使って「'ruby'.upcase」の実行結果が「'RUBY'」になっていると検証しています。
#     「assert_equalメソッド」は次のように使います。引数を渡す順番に気をつけましょう！
#　EX  assert_equal 期待する結果, テスト対象になる値や式

#[3.2.2]本書で使用するMinitestの検証メソッド
#Minitestには様々な検証メソッドが用意されていますが、本書で使うのは次の3つだけ。

assert_equal b, a  # ==> aがbと等しければパス
assert a           # ==> aが真であればパス
refute a           # ==> aが偽であればパス

#[3.2.3]テストコードの実行と結果の確認
#テストコードが書けたら次は実行です。といっても、普通のRubyファイルと実行方法は同じです。

# EX chapter_three_two_sample_test.rbを実行する場合

  $ ruby chapter_three_two_sample_test.rb

  $ ruby chapter_three_two_sample_test.rb
  Run options: --seed 15375

  # Running:

  .

  Finished in 0.000685s, 1459.8540 runs/s, 1459.8540 assertions/s.

  1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
  ryotaono@onoyuufutoshinoMacBook-Air cherry_book % 

#「Run options: --seed 15375」はテストの実行順序をシャッフルする際に使用したシード値を示していますが、ここでは特に気にしなくてOK
#「# Running:」の下に生じされている「.(ドット)」がテストの進捗状況です。今回は一つしかないのでドットは一つしか表示されません。
#「Finished in 0.000685s, 1459.8540 runs/s, 1459.8540 assertions/s.」はテストの実行スピードを表示しています。
#各値が表している内容は次の通り
  Finished in 0.000685s     # ==> テスト実行にかかった秒数
  1459.8540 runs/s          # ==> 1秒間に実行できるであろうメソッドの件数
  1459.8540 assertions/s.   # ==> 1秒間に実行できるであろう検証メソッドの件数

#最後の行がテストの実行結果のまとめです。それぞれ次の内容を表しています。
  1 runs          # ==> 実行したテストメソッドの件数
  1 assertions    # ==> 実行した検証メソッドの件数
  0 failures      # ==> 検証に失敗したメソッドのテストメソッドの件数
  0 errors        # ==> 検証中にエラーが発生したテストメソッドの件数
  0 skips　       # ==> skipメソッドにより実行をスキップされたテストメソッドの件数

#「failures」と「errors」の件数がどちらも０であればテストは全てパスしたことになります！