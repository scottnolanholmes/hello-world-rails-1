Babaloa.configure {|config|
  config.definition = {
    hello_world: {
      except: %i[updated_at created_at],
      sort:   :priority,
      t:      I18n.t("activerecord.attributes.hello_world"),
    },
    ghibli:      {
      sort: { rt_score: :desc },
      t:    I18n.t("api.ghibli.distribution.films"),
    },
  }
}
