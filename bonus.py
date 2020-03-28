#! /Users/darthnoward/anaconda3/bin/python3
#! this is a bonus script for a specific usage during covid-19 pandemic

from selenium import webdriver
from selenium.webdriver.support.ui import Select
from myinfo import username, password 
from sys import argv 
from time import time, sleep

class AutoLogin():
    def __init__(self):
        self.driver = webdriver.Chrome()

    def login(self):
        self.driver.get("https://tts.sutd.edu.sg")
        try:
            self.driver.find_element_by_xpath('//*[@id="agree_button"]').click()
        except:
            pass
        self.driver.find_element_by_xpath('//*[@id="pgContent1_uiLoginid"]').send_keys(username)
        self.driver.find_element_by_xpath('//*[@id="pgContent1_uiPassword"]').send_keys(password)
        self.driver.find_element_by_xpath('//*[@id="pgContent1_btnLogin"]').click()
        self.driver.find_element_by_xpath('//*[@id="list"]/ul/li[1]/a').click()
        self.driver.switch_to.window(self.driver.window_handles[-1])
        select = Select(self.driver.find_element_by_id("pgContent1_uiTemperature"))
        select.select_by_index(1)
        self.driver.find_element_by_xpath('//*[@id="pgContent1_btnSave"]').click()



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


