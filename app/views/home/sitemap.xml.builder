xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

    xml.url do
      xml.loc "http://rishighan.com"
      xml.priority 1.0
    end

    @posts.each do |post|
        xml.url do
            xml.lastmod post.created_at.to_date
            xml.loc post_url(post)
            xml.priority 1.0
        end
    end

    @categories.each do |cat|
        xml.url do
            xml.loc category_url(cat)
            xml.priority 1.0
         end
    end
end
