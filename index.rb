require 'mechanize'
require 'date'

agent = Mechanize.new
startUrl = "https://www.petsonic.com/hobbit-half/"

page  = agent.get(startUrl)
startTitle = page.title
i = 2
begin
    puts(i)
    links = page.xpath("//a[@class='product_img_link product-list-category-img']")
    result = links.map do |link| 
        itemPage = agent.click(link)
        name = itemPage.xpath("//h1[@class='product_main_name']").text
        nameCategory = itemPage.xpath("//span[@class='radio_label']").text
        price = itemPage.xpath("//span[@class='price_comb']").text
        image = itemPage.xpath("//img[@id='bigpic']").attr('src')
        # puts(name,nameCategory, price, image)
    end
    newPage = startUrl+"?p=" + i.to_s
    page = agent.get(newPage)
    i += 1
end while startTitle!=page.title
