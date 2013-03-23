Rails3::Application.routes.draw do
  root :to => "root#index"
  match "health" => "root#health"
  match "make_widget/:name" => "root#make_widget"
end
