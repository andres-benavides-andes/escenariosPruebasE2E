Feature: Shared board connection

  @user1 @web
  Scenario: Creaar un post
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having id "ember8"
    Then I enter "<PASSWORD>" into input field having id "ember10"
    Then I click on element having css selector "button#ember12"
    Then I wait for 12 seconds
    Then I click on element having id "ember31"
    Then I enter "Titulo prueba kraken" into input field having css selector ".gh-editor-title"
    Then I click on element having id "ember71"
    Then I enter "Test" into input field having css selector ".koenig-editor p"
    Then I wait for 5 seconds
    Then I click on element having css selector ".gh-editor-back-button"
   

    