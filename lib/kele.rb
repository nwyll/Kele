require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
  
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
  
  def get_messages(*page_number)
    if page_number.empty?
      url = "/message_threads"
      response = self.class.get(url, headers: { "authorization" => @auth_token })
    else
      url = "/message_threads?page=#{page_number[0]}"
      response = self.class.get(url, headers: { "authorization" => @auth_token }, body: { page: page_number[0] }) 
    end
    
    if response.success?
      JSON.parse(response.body)
    else
      raise response.response
    end
  end
  
  # def create_message(recipient, token, subject, text)
  #   response = self.class.post("/message_threads", headers: { "authorization" => @auth_token }, body: { 
  #     sender: @email,
  #     recipient_id: recipient,
  #     token: token,
  #     subject: subject,
  #     stripped-text: text
  #   }) 
    
  #   if response.success?
  #     "Message sent."
  #   else
  #     raise response.response
  #   end
  # end
  
end