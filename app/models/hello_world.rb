class HelloWorld < ApplicationRecord
  COUNTRY = Settings.country

  validates country,  presense: true, inclusion: { in: COUNTRY.keys }, uniqueness: true
  validates hello,    presense: true
  validates priority, priority: true
end
