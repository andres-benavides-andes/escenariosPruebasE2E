Feature: Funcion crear post/crear post
  @user1 @web
  Scenario: Creaar un post
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having id "ember8"
    Then I enter "<PASSWORD>" into input field having id "ember10"
    Then I click on element having css selector "button#ember12"
    Then I wait for 8 seconds
    Then I click on element having css selector "a[title='New post']"
    Then I enter "BIEN" into input field having css selector ".gh-editor-title"
    Then I click on element having css selector ".koenig-editor"
    Then I wait for 1 seconds
    Then I enter "Cuerpo de prueba" into input field having css selector ".koenig-editor p"
    Then I wait for 5 seconds
    Then I click on element having css selector ".gh-editor-back-button"
    Then I wait for 1 seconds
    Then I should see text "Posts"
   

    