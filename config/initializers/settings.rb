# load config/setting.yml
# SETTING is the variable stores information for each ENV setting
# ex: SETTING["hoge"]["hogehoge"]
SETTING = YAML.load_file(Rails.root.join("config", "application.yml"))[Rails.env].with_indifferent_access
