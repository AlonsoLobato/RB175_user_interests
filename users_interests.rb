require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @page_title = "Users and Interests"
  @user_list = YAML.load_file("data/users.yaml")
  @total_users = @user_list.count
  @total_interests = count_interests(@user_list)
end

helpers do
  def count_interests(hash)
    counter = 0
    hash.each_key { |key| counter += hash[key][:interests].count }
    counter
  end
end

not_found do
  redirect "/"
end

get "/" do
  redirect "/userlist"
end

get "/userlist" do
  erb :user_list
end

get "/userlist/:name" do
  @username = params[:name].to_sym

  erb :user_info
end
