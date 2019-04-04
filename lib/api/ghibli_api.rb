class Api::GhibliApi < Api::ApiBase
  def self.endpoints
    SETTING["api"]["ghibli"]
  end

  def films
    res = get(:films)
    res.sort_by {|arr| arr["rt_score"].to_i }.reverse
  end

  def converter(res)
    res.success? ? JSON.parse(res.body) : {}
  end
end
