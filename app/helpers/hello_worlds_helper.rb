module HelloWorldsHelper
  def top_animation
    "animated fadeInDown" if params[:page].blank?
  end

  def c(obj)
    SETTING[:country][obj.country]
  end

  def i(key)
    image_tag(asset_pack_path("img/#{key}.ico"))
  end
end
