Feature: Funcion crear post/Publicar post

  @user1 @web
  Scenario: Publicar un post
    Given I have a version "<VERSION_APP>"
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having id "ember8"
    Then I enter "<PASSWORD>" into input field having id "ember10"
    Then I click on element having css selector "button#ember12"
    Then I wait for 8 seconds
    Then I click on element having css selector ".gh-nav-new-post"
    Then I enter "Este esta publicado" into input field having css selector ".gh-editor-title"
    Then I click on element having css selector ".koenig-editor"
    Then I wait for 1 seconds
    Then I enter "Contenido para publicar" into input field having css selector ".koenig-editor p"
    Then I wait for 5 seconds
    Then I click on element having css selector ".gh-publishmenu .gh-publishmenu-trigger"
    Then I click on element having css selector ".gh-publishmenu-button"
    Then I wait for 3 seconds
    Then I should see text "Published"
   

    
