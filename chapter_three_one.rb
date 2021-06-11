#第３章　テストを自動化する
#[3.1]イントロダクション

#[3.1.1]この章で学ぶこと
# ・Minitestの基本
# ・FizzBuzzプログラムのテスト自動化
# ==> 第４章以降でもサンプルプログラムの動作確認はMinitestというテスティングフレームワークを使っていくので、ここで必ずテストコードを読み書きできるようにになろう！

#[3.1.2]「プログラマの三大美徳」
#プログラムの世界には「プログラマの三大美徳」と呼ばれる3つの美徳がある。

#「怠惰・短気・傲慢」
# ==> これらを備えたプログラマこそ良いプログラマとしてみなされる。

#「怠惰」
# ==> 全体の労力を減らすために手間、つまりプログラムを書いたり、コードを改善したりすることを惜しまない気質を指す。

#「短気」
# ==> コンピュータの動作が怠慢なとき、つまりプログラムの品質が悪いときに感じる怒りを指す。

#「傲慢」
# ==> 自分が書いたプログラムは誰に見せても恥ずかしくないと胸を張っていえる自尊心を指す。

#ここで「怠惰」についてもう少し詳しく考えていくと、FizzBuzzプログラムの実行結果をいちいち確認したくはありません。
#このような単純作業こそコンピュータに任せる方が適切。
#そこで登場するのがテスティングフレームを使ったテストの自動化！

#テストを自動化すればコマンド一つで実行結果をチェックしてくれるうえに、間違いがあれば教えてくれる！