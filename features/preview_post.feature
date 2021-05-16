Feature: Funcion crear post/Ver preview del post
  @user1 @web
  Scenario: Ver preview del post
    Given I have a version "3.3.0"
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having id "ember8"
    Then I enter "<PASSWORD>" into input field having id "ember10"
    Then I click on element having css selector "button#ember12"
    Then I wait for 8 seconds
    Then I click on element having css selector ".gh-nav-new-post"
    Then I enter "Ver preview" into input field having css selector ".gh-editor-title"
    Then I click on element having css selector ".koenig-editor"
    Then I wait for 1 seconds
    Then I enter "Simple preview" into input field having css selector ".koenig-editor p"
    Then I wait for 5 seconds
    Then I click on element having css selector ".post-settings"
    Then I wait for 2 seconds
    Then I click on element having css selector ".post-view-link"