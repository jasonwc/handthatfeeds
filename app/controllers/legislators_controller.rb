class LegislatorsController < ApplicationController
  def your_legislators
    @zip = '84606'

    legislators = Congress.legislators_locate(@zip)
    @junior_senator = legislators.results.detect{|f| f["state_rank"] == 'junior' }
    @senior_senator = legislators.results.detect{|f| f["state_rank"] == 'senior' }
    @representative = legislators.results.detect{|f| f["chamber"] == 'house'}
  end

  def index
  end

  def show
  end
end
