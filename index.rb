require 'mechanize'
require 'csv'

agent = Mechanize.new

startUrl = ARGV[0]
page  = agent.get(startUrl)
startTitle = page.title
pageNumber = 2

CSV.open(ARGV[1],"w") do |csv|
    begin
        links = page.xpath("//a[@class='product_img_link product-list-category-img']")
        result = links.map do |link| 
            itemPage = agent.click(link)
            currentRecord = []
            name = itemPage.xpath("//h1[@class='product_main_name']").text
            itemPage.xpath("//span[@class='radio_label']").map do |category|
                i = 0
                currentRecord.push(name + " " + category.text)
                currentRecord.push(itemPage.xpath("//span[@class='price_comb']")[i].text)
                currentRecord.push(itemPage.xpath("//img[@id='bigpic']").attr('src'))
                i+=1 
            end
            csv << currentRecord
        end
        newPage = startUrl+"?p=" + pageNumber.to_s
        page = agent.get(newPage)
        pageNumber += 1
    end while startTitle!=page.title
end