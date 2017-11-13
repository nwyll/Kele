module Roadmap
  def get_roadmap(roadmap_id)
    #example use 38
    response = self.class.get("/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token })
    
    if response.success?
      @roadmap = JSON.parse(response.body)
    else
      raise response.response
    end
  end
  
  def get_checkpoint(checkpoint_id)
    # example use 2481
    response = self.class.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
    
    if response.success?
      @checkpoint = JSON.parse(response.body)
    else
      raise response.response
    end
  end
end