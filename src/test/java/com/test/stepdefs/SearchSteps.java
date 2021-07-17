package com.test.stepdefs;

import com.searchmodule.pages.SearchPage;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.testng.Assert;

import java.net.MalformedURLException;
import java.net.URL;

public class SearchSteps{

    private SearchPage searchPage;
    private WebDriver driver;

    
    @Given("^I am on the website$")
    public void i_am_on_the_website() throws Throwable {
    	 searchPage = new SearchPage(driver);
         searchPage.goTo();
    }
    
    @Then("^I should get title as \"([^\\\"]*)\"$")
    public void i_should_get_title_as_Google(String expectedTitle) throws Throwable {
    	String actualTitle = searchPage.getUrl();
    	Assert.assertEquals(actualTitle, expectedTitle,actualTitle+" and "+expectedTitle+" are not mathching.");
    }

    @Before
    public void setupDriver() throws MalformedURLException {
    	String host = "localhost";
        ChromeOptions options = null;

        if(System.getProperty("BROWSER") != null &&
                System.getProperty("BROWSER").equalsIgnoreCase("firefox")){
        	System.out.println("firefox is not defined yet");
        }else{
            options = new ChromeOptions();
            options.addArguments("--start-maximized");
        }

        if(System.getProperty("HUB_HOST") != null){
            host = System.getProperty("HUB_HOST");
        }
    	String completeUrl = "http://" + host + ":4444/wd/hub";
    	System.out.println(completeUrl);
        driver = new RemoteWebDriver(new URL(completeUrl), options);       
    }

    @After
    public void quitDriver(){
        this.driver.quit();
    }

}