class LegislatorsController < ApplicationController
data_table = GoogleVisualr::DataTable.new

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
    # Sets @crp_id to get crp_id of current legislator
    @crp_id = params[:crp_id]

    # Get's top industries that donated to a candidate
    #TODO: put API key into secret file
    #      currently assumes that you want data from 2014, maybe want to make that variable?
    industry_result = JSON.parse(HTTParty.get('http://www.opensecrets.org/api/?method=candIndustry&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json'))
    @industries = industry_result['response']['industries']['industry']
    data_desk = GoogleVisualr::DataTable.new
    data_desk.new_column('string', 'Industry')
    data_desk.new_column('number', 'Individual')
    data_desk.new_column('number', 'Pacs')
    data_desk.new_column('number', 'Total')
    data_desk.add_rows(@industries.count)
    @industries.each_with_index do |industry, index|
      data_desk.set_cell(index, 0, industry['@attributes']['industry_name'])
      data_desk.set_cell(index, 1, industry['@attributes']['indivs'].to_i)
      data_desk.set_cell(index, 2, industry['@attributes']['pacs'].to_i)
      data_desk.set_cell(index, 3, industry['@attributes']['total'].to_i)
    end
  
    opts   = { :width => 800, :height => 480, :title => 'Contibutions by Industry', :hAxis => { :title => 'Industry', :titleTextStyle => {:color => 'red'}} }
    @hart = GoogleVisualr::Interactive::ColumnChart.new(data_desk, opts)

    # Get's top sectors that donated to a candidate
    # sector_result = JSON.parse(HTTParty.get('http://www.opensecrets.org/api/?method=candSector&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json'))
    # @sectors = sector_result['response']['sectors']['sector']

    # Get's top organizations contributing to a specified politician
    organization_result = JSON.parse(HTTParty.get('http://www.opensecrets.org/api/?method=candContrib&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json'))
    @organizations = organization_result['response']['contributors']['contributor']

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Organizations')
    data_table.new_column('number', 'Amount')
    data_table.add_rows(@organizations.count)
    @organizations.each_with_index do |org, index|
      data_table.set_cell(index, 0, org['@attributes']['org_name']    )
      data_table.set_cell(index, 1, org['@attributes']['total'].to_i    )
    end
    opts   = { :width => 800, :height => 480, :title => 'Contributions by Organization', :is3D => false, pieHole: 0.3 }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)


  end
end
