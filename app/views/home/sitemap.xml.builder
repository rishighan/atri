xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
    xml.author "Rishi Ghan"
    xml.company "The Ninth Muse"
    xml.vocation "Web Developer"
    xml.status "Consolidating"
    xml.url do
      xml.loc "http://rishighan.com"
      xml.priority 1.0
    end

    @posts.each do |post|
        xml.publish_date post.created_at
        xml.title post.title
        xml.excerpt post.excerpt
        xml.content post.content
        xml.url do
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
