module ApplicationHelper
  def google_url(title)
    "https://www.google.com/search?q=" + title.gsub(/\s/, "+")
  end

  def export_csv(path)
    link_to("Export CSV", "#{path}.csv", class: "btn btn-outline-success")
  end
end
