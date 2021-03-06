Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #Deviseを継承したgeneral_usersとshop_managersを準備する
  devise_for :general_users, {
    path: 'general_users',
    controllers: {
      registrations: 'general_users/registrations',
      sessions: 'general_users/sessions'
    }
  }

  devise_for :shop_managers, {
    path: 'shop_managers',
    controllers: {
      registrations: 'shop_managers/registrations',
      sessions: 'shop_managers/sessions'
      #get '/users/sign_out' => 'shop_manager/sessions#destroy'
    }
  }

  root 'coupons#index'

  resources :coupons do
    collection do
      post :confirm
      get :getcoupons
      get :agreement
      #追加の場合はget XXXXを追加していく
    end
    #独自のアクションを類歌する方法
    #collection do
      #get 'manager_login'
      #get 'login_check'
    #end
  end

  #resources :coupon_shop_lists , only: [:index, :new, :create] do
  resources :coupon_shop_lists do
    collection do
      post :confirm
      get :myshop
      get :issuedcoupon
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
