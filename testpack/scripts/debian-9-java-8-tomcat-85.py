#!/usr/bin/env python3

import unittest
import os
import docker
from selenium import webdriver
import time
from testpack_helper_library.unittests.dockertests import Test1and1Common


class Test1and1Java8Tomcat85Image(Test1and1Common):
    container_ip = None

    @classmethod
    def setUpClass(cls):
        Test1and1Common.setUpClass()
        details = docker.APIClient().inspect_container(container=Test1and1Common.container.id)
        Test1and1Java8Tomcat85Image.container_ip = details['NetworkSettings']['IPAddress']
        # Give the container time to spin up or we may fail a test due to a race
        time.sleep(3)

    # <tests to run>

    def test_docker_logs(self):
        expected_log_lines = [
            "Process 'catalina' changed state to 'RUNNING'",
            "Applying tomcat config",
            "org.apache.catalina.startup.Catalina.start Server startup"
        ]
        container_logs = self.container.logs().decode('utf-8')
        for expected_log_line in expected_log_lines:
            self.assertTrue(
                container_logs.find(expected_log_line) > -1,
                msg="Docker log line missing: %s from (%s)" % (expected_log_line, container_logs)
            )

    def test_tomcat8_installed(self):
        self.assertPackageIsInstalled("tomcat8")

    def test_tomcat(self):
        driver = webdriver.PhantomJS()
        driver.get("http://%s:8080/" % Test1and1Java8Tomcat85Image.container_ip)
        self.assertTrue(driver.title.find('Apache Tomcat/8.5.') > -1)

    # </tests to run>

if __name__ == '__main__':
    unittest.main(verbosity=1)
