require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
  
  base_uri 'https://www.bloc.io/api/v1'
  
  def initialize(email, password)
    @email = email
    
    response = self.class.post('/sessions', body: {
      email: @email, 
      password: password
    })
    
    if response.success?
      @auth_token = response['auth_token']
      @enrollment_id = get_me["current_enrollment"]["id"]
      @mentor_id = get_me["current_enrollment"]["mentor_id"]
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
  
  def get_mentor_availability
    response = self.class.get("/mentors/#{@mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    
    if response.success?
      JSON.parse(response.body)
    else
      raise response.response
    end
  end
  
  def get_messages(page_number=0)
    if page_number == 0
      url = "/message_threads"
      response = self.class.get(url, headers: { "authorization" => @auth_token })
    else
      url = "/message_threads?page=#{page_number}"
      response = self.class.get(url, headers: { "authorization" => @auth_token }, body: { page: page_number }) 
    end
    
    if response.success?
      JSON.parse(response.body)
    else
      raise response.response
    end
  end
  
  def create_message(subject, text, recipient=@mentor_id)
    response = self.class.post("/messages", headers: { "authorization" => @auth_token }, body: { 
      "sender" => @email,
      "recipient_id" => recipient,
      "subject" => subject,
      "stripped-text" => text
    }) 
    
    if response.success?
      "Message sent." 
    else
      raise "There was and error sending the message. Please try again."
    end
  end
  
end