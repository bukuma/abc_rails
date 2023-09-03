class CreatePosts < ActiveRecord::Migration[7.0]
  def change
  # マイグレーションを実行するとき（rails db:migrate）に呼ばれ、また逆にマイグレーションをロールバックするとき（rails db:rollback）にも呼ばれる
    create_table :posts do |t|
     # postsという名前の新しいテーブルをデータベースに作成し、do |t|からendまでの間に、テーブルのカラムを定義
      t.string :title
      # タイトル、本文を保存するためのカラムを作成する。データ型は文字列（string）
      t.string :body

      t.timestamps
      #created_atとupdated_atという2つのカラムを作成する。これらのカラムは自動的に現在の日時が設定され、レコードが作成または更新されるたびに自動的に更新される
    end
  end
end

