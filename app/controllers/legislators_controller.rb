class LegislatorsController < ApplicationController

  def your_legislators
    # quick and dirty validation for zipcode validation (need to replace with real validation)
    if params[:search] && params[:search] != '' && params[:search].match(/^\d{5}(?:[-\s]\d{4})?$/)
      # get zipcode from search function
      @zip = params[:search]
    else
      # if nil search is submitted, default to this zip
      @zip = '96741'
    end

    legislators = Congress.legislators_locate(@zip)
    @junior_senator = legislators.results.detect{|f| f["state_rank"] == 'junior' }
    @senior_senator = legislators.results.detect{|f| f["state_rank"] == 'senior' }

    @representative = legislators.results.detect{|f| f["chamber"] == 'house'}
  end

  def index
  end

  def show
    @crp_id = params[:crp_id]
    raise "  "
  end
end
