class LegislatorsController < ApplicationController
data_table = GoogleVisualr::DataTable.new

  def your_legislators
    # quick and dirty validation for zipcode validation (need to replace with real validation)
    if params[:search] && params[:search] != '' && params[:search].match(/^\d{5}(?:[-\s]\d{4})?$/)
      # get zipcode from search function
      @zip = params[:search]
    end
    if @zip
      legislators = Congress.legislators_locate(@zip)
      @junior_senator = legislators.results.detect{|f| f["state_rank"] == 'junior' }
      @senior_senator = legislators.results.detect{|f| f["state_rank"] == 'senior' }

      # @senior_senator_id = @senior_senator.crp_id

      @representative = legislators.results.detect{|f| f["chamber"] == 'house'}
    end
  end

  def index
    @search = Legislator.search(params[:q])
    @legislators = @search.result.page(params[:page]).per(5)
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @legislators }
    end
  end

  def new
    @legislator = Legislator.new
  end

  def edit
    @legislator = Legislator.find(params[:id])
  end

  def create
    @legislator = Legislator.new(params[:legislator])
  end

  def destroy
    @legislator = Legislator.find(params[:id])
    @legislator.destroy
  end

  def show
    # Sets @crp_id to get crp_id of current legislator
    @crp_id = params[:crp_id]
    @legislator = Legislator.find_by_crp_id(@crp_id)

    summary_result = JSON.parse(HTTParty.get('http://www.opensecrets.org/api/?method=candSummary&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json'))
    @summary = summary_result['response']['summary']['@attributes']
    # Get's top industries that donated to a candidate
    # TODO: put API key into secret file
    #      currently assumes that you want data from 2014, maybe want to make that variable?
    industry_result = JSON.parse(HTTParty.get('http://www.opensecrets.org/api/?method=candIndustry&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json'))
    @industries = industry_result['response']['industries']['industry']

    ind_table = GoogleVisualr::DataTable.new
    ind_table.new_column('string', 'Industry')
    ind_table.new_column('number', 'Individual')
    ind_table.new_column('number', 'Pacs')
    ind_table.new_column('number', 'Total')
    ind_table.add_rows(@industries.count)
    @industries.each_with_index do |industry, index|
      ind_table.set_cell(index, 0, industry['@attributes']['industry_name'])
      ind_table.set_cell(index, 1, industry['@attributes']['indivs'].to_i)
      ind_table.set_cell(index, 2, industry['@attributes']['pacs'].to_i)
      ind_table.set_cell(index, 3, industry['@attributes']['total'].to_i)
    end
  
    opts   = { :width => 800, :height => 480, :title => 'Contibutions by Industry', colors: ['#8bbf36', '#5D7F24', '#2E4012'], :hAxis => { :title => 'Industry'} }
    @industries_chart = GoogleVisualr::Interactive::ColumnChart.new(ind_table, opts)

    # Get's top sectors that donated to a candidate
    sector_result = JSON.parse(HTTParty.get('http://www.opensecrets.org/api/?method=candSector&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json'))
    @sectors = sector_result['response']['sectors']['sector']

    sec_table = GoogleVisualr::DataTable.new
    sec_table.new_column('string', 'Sector')
    sec_table.new_column('number', 'Individual')
    sec_table.new_column('number', 'Pacs')
    sec_table.new_column('number', 'Total')
    sec_table.add_rows(@sectors.count)
    @sectors.each_with_index do |sector, index|
      sec_table.set_cell(index, 0, sector['@attributes']['sector_name'])
      sec_table.set_cell(index, 1, sector['@attributes']['indivs'].to_i)
      sec_table.set_cell(index, 2, sector['@attributes']['pacs'].to_i)
      sec_table.set_cell(index, 3, sector['@attributes']['total'].to_i)
    end
    opts   = { :width => 800, :height => 480, :title => 'Contibutions by Sector', colors: ['#8bbf36', '#5D7F24', '#2E4012'], :hAxis => { :title => 'Industry'} }
    @sectors_chart = GoogleVisualr::Interactive::ColumnChart.new(sec_table, opts)

    # Get's top organizations contributing to a specified politician
    organization_result = JSON.parse(HTTParty.get('http://www.opensecrets.org/api/?method=candContrib&cid=' + @crp_id + '&cycle=2014&apikey=4daceaa6ff5b929ecdda3321b36caf76&output=json'))
    @organizations = organization_result['response']['contributors']['contributor']

    org_table = GoogleVisualr::DataTable.new
    org_table.new_column('string', 'Organizations')
    org_table.new_column('number', 'Amount')
    org_table.add_rows(@organizations.count)
    @organizations.each_with_index do |org, index|
      org_table.set_cell(index, 0, org['@attributes']['org_name']    )
      org_table.set_cell(index, 1, org['@attributes']['total'].to_i    )
    end
    opts   = { :width => 800, :height => 480, :title => 'Contributions by Organization', :is3D => false, pieHole: 0.3 }
    @organizations_chart = GoogleVisualr::Interactive::PieChart.new(org_table, opts)


  end

  def follow
  legislator = Legislator.find(params[:id])
  current_user.follow(legislator)
  redirect_to user_path(current_user)
  end

  def unfollow
    legislator = Legislator.find(params[:id])
    current_user.stop_following(legislator)
    redirect_to user_path(current_user)
  end
end
