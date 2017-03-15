Rails.application.routes.draw do
  get '/resumes' => 'resumes#index'
  get '/resumes/:id' => 'resumes#show'
end
