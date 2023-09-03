class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @title = params[:title]
    # ここで、params[:title]とはURLから送られてくるパラメータ（データ）の中からタイトルに関する情報を取得していく。
    # 例えば、サイトのURLがhttp://xxxx.com/?title=myTitleだとすれば、params[:title]はmyTitleという文字列を返す。
    # この情報は@titleというインスタンス変数に保存され、その後の処理で利用される。
    if @title.present?
      # ここでは@titleが存在するかどうかをチェックしている。ユーザーが何かタイトルを検索している場合はこの処理が実行される。
      @posts = Post.where('title LIKE ?', "%#{@title}%")
      # 検索処理。where('title LIKE ?', "%#{@title}%")という部分はSQLクエリを形成していて、titleというフィールドが@titleの文字列を含む全てのPostオブジェクトを探している。

    else
      # 検索していない場合
      @posts = Post.all
      # 検索していない場合は、全てのPostオブジェクトを取得する。←すべての投稿を表示するため。
    end
    render :index
  end

  # 2-10 ここから
  def new
    # new.html.erbでは@postの変数を使用するため、インスタンスを生成
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    # まず最初に、新しいPostオブジェクトを作成する。
    # その際にpost_paramsメソッドを通じて受け取ったパラメータ（タイトル、本文、画像など）を使って初期化する。
    # ここで、post_paramsはユーザーから送られてきたデータのうち、安全に使用できるデータをフィルタリングする役割を果たす。

    if params[:post][:image]
      # ユーザーが画像を送信してきた場合に対応。
      # この条件分岐は、送信データ（params[:post][:image]）に画像が含まれているかどうかを確認する。
      @post.image.attach(params[:post][:image])
      # 画像が送信されてきた場合、その画像を@postオブジェクトにアタッチ（添付）する
    end

    if @post.save
      # ここで、@postオブジェクトをデータベースに保存する。
      # 保存が成功すればtrueを返し、何らかの問題で保存できなければfalseを返す。
      redirect_to index_post_path, notice: '登録しました'
      #  保存が成功した場合、ユーザーを投稿一覧ページ（"/"）にリダイレクトさせる。
      # その際、「登録しました」という通知メッセージを表示する。
    else
      # 登録に失敗した場合

      render :new, status: :unprocessable_entity
      # 保存が失敗した場合、再度新規投稿フォーム（:newビュー）を表示。
      # その際、HTTPステータスコードとして422（Unprocessable Entity）を返す。
      # これは、リクエストは理解されたが、バリデーションエラーや他の理由で処理できなかったことを意味する。
    end
  end

  # 2-12 追記
  def edit
    # editメソッドは、ユーザーがデータを編集するためのページを表示するためのもの。ここでは、特定の投稿を編集するための画面を表示。
  
   @post = Post.find(params[:id])
      # URLから取得したidパラメータを使用して、データベースから対象の投稿を取得する。
      # 取得した投稿はインスタンス変数@postに保存される。
      # インスタンス変数に保存することで、その変数はビュー内でも利用可能になる。
  
    render :edit
  end
  
  def update
    # updateメソッドは、実際にデータベースの情報を更新するためのもの。
  
    @post = Post.find(params[:id])
      # URLから取得したidパラメータを使用して、データベースから対象の投稿を取得。
  
    if params[:post][:image]
      # 送信されたパラメータに画像が含まれているかどうかをチェック。
  
      @post.image.attach(params[:post][:image])
        # もし含まれていれば、その画像を投稿に紐づける。
  
    end
  
    if @post.update(post_params)
      # post_paramsというメソッドで送信データを適切にフィルターし（不正なデータの更新を防ぐため）、そのデータを使って投稿を更新します。
      # 更新に成功したら、trueを返す。
  
      redirect_to index_post_path, notice: '更新しました'
        # 更新に成功した場合は'更新しました'で投稿一覧ページにリダイレクトする。
  
    else
      # 更新に失敗した場合（例えば、バリデーションに失敗するなど）
  
      render :edit, status: :unprocessable_entity
        # 失敗した場合は、編集画面を再度表示する。
        # この時、エラーメッセージとともにフォームが表示され、ユーザーにどの部分が間違っているかを知らせる。
    end
  end
  
  # 2-12 追加
  def destroy
    # データベースのレコードを削除するために使用される。ここでは、投稿（Post）のレコードを削除するために使っている。
  
    @post = Post.find(params[:id])
      # URLから投稿のID（params[:id]）を取得して、それに対応する投稿をデータベースから探す。そして、その投稿のデータをインスタンス変数@postに代入する。
  
    @post.destroy
      # @postオブジェクト（つまりデータベースの一つの投稿レコード）を削除。この操作はデータベースからそのレコードを完全に取り除く。
  
    redirect_to index_post_path, notice: '削除しました'
      # 投稿が削除されたら、ユーザーを投稿の一覧画面（index）にリダイレクトする。
      # 同時に、'削除しました'という通知メッセージも表示する。
  
  end

  private
  # post_paramsメソッドは、RailsのStrong Parametersと呼ばれる機能を用いたもの。
  # このメソッドは、ユーザーから送られてきたパラメータ（データ）から安全に使用可能なものだけを抽出・フィルタリングする役割を果たす。
  # Strong Parametersは、安全性のために重要な機能で、想定外のパラメータによる不正なデータ操作（マスアサインメント脆弱性）を防ぐ役割がある。
  def post_params

    params.require(:post).permit(:title, :body, :image)
    # params.require(:post)の説明
    # paramsは送られてきたパラメータ（データ）全体を保持するハッシュのようなオブジェクト。
    # require(:post)は、その中から:postキーを持つデータを取り出す。
    # :postキーが存在しない場合、例外（エラー）が発生。

    # permit(:title, :body, :image)の説明
    # permitメソッドは、:postキーの中からさらに指定したキー（この場合、:title、:body、:image）のみを抽。
    # これにより、これら以外のパラメータが送られてきてもそれらは無視され、データベースに影響を与えることはない。
  end
  # 2-10 ここまで
end
