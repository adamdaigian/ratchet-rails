RatchetRails::Application.routes.draw do
  root :to => 'home#show'
  match 'ratchet' => 'ratchet#show', :as => :ratchet
end
