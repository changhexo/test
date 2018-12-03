import requests
from lxml import etree


class QiuShiBaiKe:
    def __init__(self):
        self.start_url = 'https://www.qiushibaike.com/8hr/page/{}'
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
        }

    def get_url_list(self):
        return [self.start_url.format(i) for i in range(1, 14)]

    def parse_url(self, url):
        # print(url)
        response = requests.get(url, headers=self.headers)
        return response.content.decode()

    def get_content_list(self, html_str):
        html = etree.HTML(html_str)
        div_list = html.xpath("//div[@id='content-left']/div")
        content_list = []
        for div in div_list:
            item = {}
            item['content'] = div.xpath(".//div[@class='content']/span/text()")
            item['content'] = [i.replace('\n', '') for i in item['content']]
            content_list.append(item)
        return content_list

    def save_content_list(self, content_list):
        with open('qiubai.txt', 'a', encoding='utf-8') as f:
            for i in content_list:
                print(i)
                f.write(i['content'][0])
                f.write('\n')
                f.write('-'*20)
                f.write('\n')

    def run(self):
        # url_list
        url_list = self.get_url_list()
        # 遍历，发送请求
        for url in url_list:
            html_str = self.parse_url(url)
            # 提取数据
            content_list = self.get_content_list(html_str)
            # 保存数据
            self.save_content_list(content_list)


if __name__ == '__main__':
    qiushibaike = QiuShiBaiKe()
    qiushibaike.run()
