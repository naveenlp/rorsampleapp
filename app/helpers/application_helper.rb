module ApplicationHelper
	def full_title(page_title)
		title = "Ruby on Rails Tutorial Sample App"
		if(!page_title.empty?)
			"#{title} | #{page_title}"
		else
			title
		end
	end
end
