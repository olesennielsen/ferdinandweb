Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '313433805396976', '7b38053a93a17abe015d0744e33aa407'
end