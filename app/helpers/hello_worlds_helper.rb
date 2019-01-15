module HelloWorldsHelper
  def c(obj)
    SETTING[:country][obj.country]
  end

  def i(key)
    image_tag(asset_pack_path("img/#{key}.ico"))
  end
end
