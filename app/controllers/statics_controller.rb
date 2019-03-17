class StaticsController < ApplicationController
  def about; end

  def sample_form; end

  def ghibli
    @films = Api::GhibliApi.new.films
    respond_to do |format|
      format.html
      format.csv {
        send_data(File::Csv.export(:ghibli, @films, yml: "api.ghibli.distribution.films"), filename: "ghibli_films.csv", type: :csv)
      }
    end
  end
end
