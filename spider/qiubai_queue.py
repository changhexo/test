import requests
from lxml import etree
import threading
from queue import Queue


class QiuShiBaiKe:
    def __init__(self):
        self.url_temp = 'https://www.qiushibaike.com/8hr/page/{}'
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
        }
        self.url_queue = Queue()
        self.html_queue = Queue()
        self.content_queue = Queue()

    def get_url_list(self):
        # return [self.start_url.format(i) for i in range(1, 14)]
        for i in range(1, 14):
            self.url_queue.put(self.url_temp.format(i))

    def parse_url(self):
        while True:
            url = self.url_queue.get()
            print(url)
            response = requests.get(url, headers=self.headers)
            self.html_queue.put(response.content.decode())
            self.url_queue.task_done()
            # return response.content.decode()

    def get_content_list(self):
        while True:
            html_str = self.html_queue.get()
            html = etree.HTML(html_str)
            div_list = html.xpath("//div[@id='content-left']/div")
            content_list = []
            for div in div_list:
                item = {}
                item['content'] = div.xpath(".//div[@class='content']/span/text()")
                item['content'] = [i.replace('\n', '') for i in item['content']]
                content_list.append(item)
            # return content_list
            self.content_queue.put(content_list)
            self.html_queue.task_done()

    def save_content_list(self):
        while True:
            content_list = self.content_queue.get()
            with open('qiubai.txt', 'a', encoding='utf-8') as f:
                for i in content_list:
                    # print(i)
                    f.write(i['content'][0])
                    f.write('\n')
                    f.write('-'*20)
                    f.write('\n')
            self.content_queue.task_done()

    def run(self):
        thread_list = []
        # url_list
        t_url = threading.Thread(target=self.get_url_list)
        thread_list.append(t_url)
        # 遍历，发送请求
        for i in range(20):
            t_parse = threading.Thread(target=self.parse_url)
            thread_list.append(t_parse)
        # 提取数据
        for i in range(3):
            t_html = threading.Thread(target=self.get_content_list)
            thread_list.append(t_html)
        # 保存数据
        t_save = threading.Thread(target=self.save_content_list)
        thread_list.append(t_save)
        for t in thread_list:
            t.setDaemon(True)  # 把子线程设置为守护线程，该线程不重要，主线程结束，了线程结束
            t.start()

        for q in [self.url_queue, self.html_queue, self.content_queue]:
            q.join()  # 让主线程等待阻塞，等待队列的任务完成后再完成

        print('-----主线程结束------')


if __name__ == '__main__':
    qiushibaike = QiuShiBaiKe()
    qiushibaike.run()
