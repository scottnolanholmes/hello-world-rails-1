require "csv"

module File::Csv
  HEADER_DIFINITIONS = {
    hello_world: %i(country priority hello image),
    ghibli:      %i(rt_score title director release_date)
  }.freeze

  class << self
    def export(key, data, yml: false)
      headers = HEADER_DIFINITIONS[key]
      ht = (yml ? I18n.t(yml).try(:values) : I18n.t("activerecord.attributes.#{key}").try(:values)) || headers
      CSV.generate do |csv|
        csv << ht
        data.each{|res|
          res = res.with_indifferent_access if res.is_a?(Hash)
          csv << headers.map {|k| res[k] }
        }
      end
    end
  end
end
