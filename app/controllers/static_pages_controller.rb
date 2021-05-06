class StaticPagesController < ApplicationController
  def home
    # => app/views/#{リソース名}/@{アクション名}.html.erb
    # => app/views/static-pages/home.html.erb
  end

  def help
  end
  
  def about
  # => app/views/static-pages/home.html.erbのデフォルト呼び出しが
  end
  
  def contact
  end
  
end
