class SearchController < ApplicationController
    def search
        if params[:stsearch]
            client = Swiftype::Client.new
            @results = client.search(ENV['SWIFTYPE_ENGINE_SLUG'], params[:stsearch], {per_page: '5', page: params[:page] || 1})
            @article_results = @results['articles']
        else
            raise "Fuck"
        end
    end
end
