class ArticlesController < ApplicationController
    def wall
        @articles = Article.all
    end

    def doPosting
        article = Article.new
        article.title = params[:newPageTitle]
        article.imageurl = params[:newPageImage]
        article.content = params[:newPageContent]
        article.username = cookies[:logged_in]

        status = article.save
        if (status)
            flash[:success] = "Article published"
            redirect_to wall_path
            return
        else
            flash.now[:danger] = "Something seems fishy... is your post long enough? (> 100 ch)"
            render "static_pages/_createArticle.html.erb"
            return
        end

    end
end
