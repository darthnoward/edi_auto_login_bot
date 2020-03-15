#! /Users/darthnoward/anaconda3/bin/python 

from selenium import webdriver
from myinfo import username, password 
from sys import argv 
from time import time, sleep

class AutoLogin():
    def __init__(self):
        self.driver = webdriver.Chrome()

    def login(self):
        self.driver.get("https://edimension.sutd.edu.sg")
        try:
            self.driver.find_element_by_xpath('//*[@id="agree_button"]').click()
        except:
            pass
        self.driver.find_element_by_xpath('//*[@id="loginOptionsMobile"]/div[2]').click()
        self.driver.find_element_by_xpath('//*[@id="userNameInput"]').send_keys(username)
        self.driver.find_element_by_xpath('//*[@id="passwordInput"]').send_keys(password)
        self.driver.find_element_by_xpath('//*[@id="submitButton"]').click()

    def content(self, subject):
        if subject.startswith("ma"):
            self.click_subject('//*[@id="_3_1termCourses_noterm"]/ul/li[13]/a')
            while True:
                try:
                    self.click_subject('//*[@id="paletteItem:_20514_1"]/a/span')
                    break
                except:
                    try:
                        self.click_subject('//*[@id="menuPuller"]')
                    except:
                        pass
            
        elif subject.startswith("ph"):
            self.click_subject('//*[@id="_3_1termCourses_noterm"]/ul/li[12]/a')

        elif subject.startswith("d"):
            self.click_subject('//*[@id="_3_1termCourses_noterm"]/ul/li[15]/a')

        elif subject.startswith("bi"):
            self.click_subject('//*[@id="_3_1termCourses_noterm"]/ul/li[17]/a')
            while True:
                try:
                    self.click_subject('//*[@id="paletteItem:_20412_1"]/a/span')
                    break
                except:
                    try:
                        self.click_subject('//*[@id="menuPuller"]')
                    except:
                        pass

        else:
            raise Exception('Bruh no such subject like \"{}\"!'.format(subject))

    def click_subject(self, xpath):
        self.driver.find_element_by_xpath(xpath).click()

browser = AutoLogin()

init = time()
while True:
    try:
        browser.login()
        break 
    except:
        sleep(0.05)
    if time() > init + 10:
        raise Exception('Operation Timeout! Please check your internet connection!')

if len(argv) == 1:
    pass 
else:
    while True:
        try:
            browser.content(argv[1])
            break
        except:
            sleep(0.05)
            continue

