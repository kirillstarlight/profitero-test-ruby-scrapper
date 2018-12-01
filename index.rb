require 'mechanize'
require 'date'

agent = Mechanize.new
page  = agent.get("https://www.petsonic.com/hobbit-half/")

links = page.xpath("//a[@class='product_img_link product-list-category-img']")

result = links.map do |link| 
    itemPage = agent.click(link)
    name = itemPage.xpath("//h1[@class='product_main_name']").text
    price = itemPage.xpath("//div[@class='attribute_list']")
    image = itemPage.xpath("//img[@id='bigpic']")
    puts(name, price, image,"=====================")
end