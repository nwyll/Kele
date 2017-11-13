require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  
  #don't know if this is neccessary
  attr_accessor :email, :password
  
  def initialize(email, password)
    @email, @password = email, password #or this
    
    response = self.class.post('/sessions', body: {
      email: @email, 
      password: @password
    })
    
    if response.success?
      @user_auth_token = response['auth_token']
    else
      raise "Invalid username or password. Please try again"
    end
  end
  
end