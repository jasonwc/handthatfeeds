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
    result = JSON.parse(HTTParty.get('http://www.opensecrets.org/api/?method=candIndustry&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json'))
    @industries = result['response']['industries']['industry']
    # industries.each do |industry|
    #   puts industry['industry_name']
    #   puts industry['indivs']
    #   puts industry['pacs']
    #   puts industry['total']
    # end
    # raise ' '
  end
end
