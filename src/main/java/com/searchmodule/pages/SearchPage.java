package com.searchmodule.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.List;

public class SearchPage {

    private WebDriver driver;
    private WebDriverWait wait;
    
    public SearchPage(WebDriver driver){
        this.driver = driver;
        this.wait = new WebDriverWait(driver, 30);
        PageFactory.initElements(driver, this);
    }
    
	public String getUrl() {
		System.out.println(driver.getTitle());
		return this.driver.getTitle();
	}

    public void goTo(){
        this.driver.get("https://www.google.com/");
        System.out.println("test2");
    }

}
