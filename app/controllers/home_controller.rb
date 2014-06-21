class HomeController < ActionController::Base
	def index
		@events = Event.where(:is_public => true).where("celebrated_at > (?)", Date.yesterday)
    @articles = Article.where(:published => true, :active=>true).order('created_at desc').limit(5)
	end
end