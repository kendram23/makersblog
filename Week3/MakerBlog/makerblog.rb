require 'unirest'

# response = Unirest.get('http://makerblog.herokuapp.com/posts',
#   headers: { "Accept" => "application/json" })

# puts response
# puts response.code

module MakerBlog
  class Client
    def list_posts
      response = Unirest.get('http://makerblog.herokuapp.com/posts',
        headers: { "Accept" => "application/json" })
      posts = response.body
      posts.each do |post|
      	puts "#{posts}"
      end
    end

    def show_posts(id)
    	url = "http://makerblog.herokuapp.com/posts/" + id.to_s
    	response = Unirest.get(url, 
    		headers: {"Accept" => 'application/json'})
    	puts response.body
    end

    def create_posts(name,title,content)
    	url = "http://makerblog.herokuapp.com/posts"
    	payload = {:post =>{'name' => name, 'title' => title, 'content' => content}}

    	response = Unirest.post(url,
    		headers: { "Accept" => "application/json",
    			"Content-Type" => "application/json"},
    			parameters: payload)

    	payload[:post].each do |key,value|
    		puts "#{key}: #{value}"
    	end
    end

    def edit_post(id, options={})
    	url = "http://makerblog.herokuapp.com/posts/"+ id.to_s
    	params = {}

    	params[:name] = options[:name] unless options[:name].nil?
  		params[:title] = options[:title] unless options[:title].nil?
  		params[:content] = options[:content] unless options[:content].nil?

  		response = Unirest.put(url,
		parameters: {:post => params}, 
		headers: {"Accept" => "application/json",
				  "Content-Type" => "application/json"})

  		params.each do |key,value|
  			puts "#{key}: #{value}"
    	end
  	end

  	def delete_post(id)
  		url = "http://makerblog.herokuapp.com/posts" + id.to_s
  		response = Unirest.delete(url,
  			headers: {"Accept" => "application/json"})
  		if (response.code == 200 || response.code == 201 || response.code == 204)
  			puts response.code
  		else
  			puts "You're request was not successful"
  		end
  	end
  end
end

 client = MakerBlog::Client.new
 # client.list_posts
 # client.show_posts(481)
 # client.create_posts("Hello", "World", "Se dig snart")

 # client.edit_post(25, {:name => "Snake Plissssken", :content => "Escape from LA"})
 client.delete_post(529)