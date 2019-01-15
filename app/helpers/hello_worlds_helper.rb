module HelloWorldsHelper
  def c(obj)
    SETTING[:country][obj.country]
  end

  def i(key)
    image_tag "../img/#{key}.ico"
  end
end
