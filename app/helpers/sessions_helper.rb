module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    # DBへの問い合わせの数を出来る限り減らしたい
    # ログインしているかのチェック（logged_in?）の問い合わせが起こるたびにcurrent_userが呼び出される
    # メモ化：一旦インスタンス変数にしておくことで、何度問いあわされてもDBへの問い合わせが減る
    if session[:user_id]
      # ||=は or or =の意味
      # @user = 左@user || 右User.find
      # 左もしくは右がtrueの場合に@userに代入される
      # コンピュータの性質として、左がtrueなら右は実行されず左が代入され、左がfalse/nilなら右が代入される
      # つまりインスタンス変数に値が入っている二回目ならば、左が入っているので何もされず、右は実行されない（＝DBへ問い合わせなし）
      @current_user ||= User.find_by(id: session[:user_id])
      # インスタンス変数の場合は、存在しないメッセージパッシングをするとnilが返ってくる。ローカル変数はエラーとなる。
      # if @current_user.nil?
      #   @current_user = User.find_by(id: session[:user_id]) 
      #   return @current_user
      # else
      # インスタンス変数に入っている場合は、そのまま（DB問い合わせ発生しない）
      #   return @current_user
      # end
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end


  # 渡されたユーザーがカレントユーザーであればtrueを返す
  def current_user?(user)
    user && user == current_user
  end
  
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
  
end
