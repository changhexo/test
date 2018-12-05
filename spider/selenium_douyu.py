from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time


# Chrome无头模式（无界面模式）
chrome_options = Options()
chrome_options.add_argument('--headless')
# 实例化浏览器
dirvie = webdriver.Chrome(chrome_options=chrome_options)
dirvie.get('https://www.douyu.com/directory/all')
# # 房间名
# room_name_list = dirvie.find_elements_by_class_name('ellipsis')
# for room_name in room_name_list:
#     print(room_name.text)
# # 房间分类
# room_tag_list = dirvie.find_elements_by_class_name('tag')
# for room_tag in room_tag_list:
#     print(room_tag.text)
# # 主播名
# roomer_name_list = dirvie.find_elements_by_class_name('dy-name')
# for roomer_name in roomer_name_list:
#     print(roomer_name.text)
# # 热度
# hot_list = dirvie.find_elements_by_class_name('dy-num')
# for hot in hot_list:
#     print(hot.text)
# 获取页数
pages = dirvie.find_elements_by_xpath("//div[@id='J-pager']/a")
num = int(pages[-3].text)


def get_content():
    room = []
    room_list_selenium = dirvie.find_elements_by_xpath("//ul[@id='live-list-contentbox']/li")
    for room_lsit in room_list_selenium:
        # room_name = room_lsit.find_element_by_xpath(".//h3[@class='ellipsis']").text
        title = room_lsit.find_element_by_xpath("./a").get_attribute("title")
        # print(title)
        # print(room_name)
        tag = room_lsit.find_element_by_xpath(".//span[@class='tag ellipsis']").text
        # print(tag)
        name = room_lsit.find_element_by_xpath(".//span[@class='dy-name ellipsis fl']").text
        # print(name)
        hot = room_lsit.find_element_by_xpath(".//span[@class='dy-num fr']").text
        # # print(hot)
        url = room_lsit.find_element_by_xpath("./a").get_attribute("href")
        # 构建字典
        temp = {'title': title, 'tag': tag, 'name': name, 'hot': hot, 'url': url}
        room.append(temp)
    return room


for i in range(1, num):
    ret = get_content()
    with open('douyu.txt', 'a', encoding='utf-8') as f:
        for val in ret:
            f.write(str(val))
            f.write('\n')
    print('第%d页保存成功' % i)
    next_url = dirvie.find_element_by_link_text("下一页").click()
    print('下一页，等待5秒加载网页(%d)' % (i+1))
    time.sleep(5)

dirvie.quit()
