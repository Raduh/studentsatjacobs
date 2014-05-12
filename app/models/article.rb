class CreateOrUpdateSwiftypeDocumentJob < Struct.new(:article_id)
    def perform
        article = Article.find(article_id)
        client = Swiftype::Client.new
        client.create_or_update_document(ENV['SWIFTYPE_ENGINE_SLUG'],
                                         "articles",
                                         {:external_id => article.id,
                                          :fields => [{:name => 'title', :value => article.title, :type => 'string'},
                                                      {:name => 'content', :value => article.content, :type => 'text'},
                                                      {:name => 'created_at', :value => article.created_at.iso8601, :type => 'date'}]})
    end
end

class DeleteSwiftypeDocumentJob < Struct.new(:article_id)
    def perform
        client = Swiftype::Client.new
        client.destroy_document(ENV['SWIFTYPE_ENGINE_SLUG'], Article.model_name.downcase, article_id)
    end
end

class Article < ActiveRecord::Base
  attr_accessible :content, :imageurl
  belongs_to :user
  validates :username, presence: true
  validates :content,  presence: true, length: { minimum: 100 }

  default_scope order: 'articles.created_at DESC'

  after_save :enqueue_create_or_update_document_job
  after_destroy :enqueue_delete_document_job

  private

  def enqueue_create_or_update_document_job
      Delayed::Job.enqueue CreateOrUpdateSwiftypeDocumentJob.new(self.id)
  end

  def enqueue_delete_document_job
      Delayed::Job.enqueue DeleteSwiftypeDocumentJob.new(self.id)
  end
end
