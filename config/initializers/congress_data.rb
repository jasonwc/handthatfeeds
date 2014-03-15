require "net/http" 
require 'pry'

module CongressData   
  class LegislatorSeed

    def create_legislators
      data = { 'results' => true }
      page = 0
      while data['results']
        data = get_congress_data(page += 1)
        data['results'].each do |result|
          create_legislator result
        end
      end
    end

    private

    def get_congress_data(page=1)
      uri = URI("https://congress.api.sunlightfoundation.com/legislators")
      params = { apikey: 'd9bc2707c3f149c79b2c4b6ce01e098c', per_page: '50', page: page }
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body)
    end

    def create_legislator(legislator)
      Legislator.create legislator.symbolize_keys.slice(:bioguide_id, :chamber, :contact_form, :facebook_id, :first_name, :last_name, :office, :party, :phone, :profile_picture, :state_name, :title, :twitter_id, :website, :crp_id)
    end

  end
end
