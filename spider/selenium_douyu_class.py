from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time


class DouYuSpider(object):
    def __init__(self):
        # Chrome无头模式（无界面模式）
        chrome_options = Options()
        chrome_options.add_argument('--headless')
        # 实例化浏览器
        self.driver = webdriver.Chrome(chrome_options=chrome_options)
        self.start_url = 'https://www.douyu.com/directory/all'
        # 获取页数
        # pages = driver.find_elements_by_xpath("//div[@id='J-pager']/a")
        # print(pages)
        # self.num = int(pages[-3].text)
        # print(num)

    def __del__(self):
        self.driver.quit()

    def get_content_list(self):
        room_list_selenium = self.driver.find_elements_by_xpath("//ul[@id='live-list-contentbox']/li")
        # print(len(room_list_selenium))
        content_list = []
        for room_list in room_list_selenium:
            item = {}
            # 房间名
            item['title'] = room_list.find_element_by_xpath("./a").get_attribute("title")
            # 标签
            item['tag'] = room_list.find_element_by_xpath(".//span[@class='tag ellipsis']").text
            # 主播
            item['anchor'] = room_list.find_element_by_xpath(".//span[@class='dy-name ellipsis fl']").text
            # 热度值
            item['hot'] = room_list.find_element_by_xpath(".//span[@class='dy-num fr']").text
            # 房间链接
            item['url'] = room_list.find_element_by_xpath("./a").get_attribute("href")
            print(item)
            content_list.append(item)
        # 获取下一页元素
        next_url = self.driver.find_elements_by_xpath("//a[@class='shark-pager-next']")
        next_url = next_url[0] if len(next_url) > 0 else None
        return content_list, next_url

    def save_content_list(self, content_list):
        for i in content_list:
            with open('douYu_list.txt', 'a', encoding='utf-8') as f:
                f.write(str(i))
                f.write('\n')

    def run(self):  # 主要逻辑
        # start_url
        # 发送请求
        self.driver.get(self.start_url)
        # 提取数据，提取下一页
        content_list, next_url = self.get_content_list()
        # 保存数据
        self.save_content_list(content_list)
        # 点击下一页元素，循环
        while next_url is not None:
            next_url.click()
            time.sleep(3)  # 等待页面加载，否则翻页后有可能元素找不到
            content_list, next_url = self.get_content_list()
            self.save_content_list(content_list)


if __name__ == '__main__':
    douYuSpider = DouYuSpider()
    douYuSpider.run()
