Feature: Funcion crear post/Publicar solo con acceso para miembros

  @user1 @web
  Scenario: Publicar un post solo con acceso para miembros
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having id "ember8"
    Then I enter "<PASSWORD>" into input field having id "ember10"
    Then I click on element having css selector "button#ember12"
    Then I wait for 8 seconds
    Then I click on element having css selector "a[title='New post']"
    Then I enter "Este esta publicado" into input field having css selector ".gh-editor-title"
    Then I click on element having css selector ".koenig-editor"
    Then I wait for 1 seconds
    Then I enter "Contenido para publicar solo para miembros" into input field having css selector ".koenig-editor p"

    Then I wait for 5 seconds
    Then I click on element having css selector ".gh-actions-cog"
    Then I select option with value "members" for dropdown having css selector ".gh-select select"
    Then I wait for 2 seconds
    Then I click on element having css selector ".settings-menu-header-action"
    

    Then I click on element having css selector ".gh-publishmenu"
    Then I click on element having css selector ".gh-publishmenu-button"
    Then I wait for 3 seconds
    Then I should see text "Published"