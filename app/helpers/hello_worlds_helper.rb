module HelloWorldsHelper
  def c(obj)
    SETTING[:country][obj.country]
  end
end
