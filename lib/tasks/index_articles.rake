task :index_articles => :environment do
  if ENV['SWIFTYPE_API_KEY'].blank?
    abort("SWIFTYPE_API_KEY not set")
  end

  if ENV['SWIFTYPE_ENGINE_SLUG'].blank?
    abort("SWIFTYPE_ENGINE_SLUG not set")
  end

  client = Swiftype::Client.new

  Article.find_in_batches(:batch_size => 100) do |articles|
    documents = articles.map do |article|
      {:external_id => article.id,
       :fields => [{:name => 'title', :value => article.title, :type => 'string'},
                   {:name => 'body', :value => article.content, :type => 'text'},
                   {:name => 'created_at', :value => article.created_at.iso8601, :type => 'date'}]}
    end

    results = client.create_or_update_documents(ENV['SWIFTYPE_ENGINE_SLUG'], "articles", documents)

    results.each_with_index do |result, index|
      puts "Could not create #{articles[index].title} (##{articles[index].id})" if result == false
    end
  end
end
