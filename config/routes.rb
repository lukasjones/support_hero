Rails.application.routes.draw do

  root 'users#index'
  
  # user routes
  resources :users, only: [:show, :index, :update]
  post 'find'             => 'users#find'
  put '/changemonth/:num' => 'calendar#change_month'

  # scheduled_month routes
  get 'get_month/:month_num' => 'scheduled_months#get_month'
  get 'get_next_month'       => 'scheduled_months#get_next_month'
  get 'get_prev_month'       => 'scheduled_months#get_prev_month'
  get 'get_month_num'        => 'scheduled_months#get_month_num'

  # day routes
  put 'swap_day'     => 'days#swap_day'
  put 'confirm_swap' => 'days#confirm_swap'
  put 'reject_swap'  => 'days#reject_swap'

end
