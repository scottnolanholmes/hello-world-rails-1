module ApplicationHelper
  def google_url(title)
    "https://www.google.com/search?q=" + title.gsub(/\s/, "+")
  end
end
