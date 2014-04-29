class ArticlesController < ApplicationController
    def wall
        @articles = Article.all
    end
end
