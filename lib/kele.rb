require 'httparty'
require 'json'

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
      @auth_token = response['auth_token']
    else
      raise "Invalid username or password. Please try again"
    end
  end
  
  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    
    if response.success?
      JSON.parse(response.body)
    else
      raise response.response
    end
  end
  
  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    
    if response.success?
      JSON.parse(response.body)
    else
      raise response.response
    end
  end
  
end