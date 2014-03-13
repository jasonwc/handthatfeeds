class LegislatorsController < ApplicationController
  def your_legislators
    @zip = '96741'

    legislators = Congress.legislators_locate(@zip)
    @junior_senator = legislators.results.detect{|f| f["state_rank"] == 'junior' }
    @senior_senator = legislators.results.detect{|f| f["state_rank"] == 'senior' }

    @representative = legislators.results.detect{|f| f["chamber"] == 'house'}


  end

  def index
  end

  def show
    @crp_id = params[:crp_id]
    result = HTTParty.get('http://www.opensecrets.org/api/?method=candIndustry&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json')
    industry = result.body
    raise ' '
  end
end
