Rails.application.routes.draw do
  root to: 'blogs#index'
  resources :blogs
  resources :posts do
    resources :comments, only: [:create]
  end

  # 2. カレンダー機能の設定（※導入方法によって名前は変わります。例: simple_calendarなど）
  # resources :calendars 
  
  # 3. トップページをどちらにするか（現在はカレンダーになっていませんか？）
end
