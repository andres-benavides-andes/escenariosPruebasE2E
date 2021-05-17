Feature: Funcion despublicar post
  @user1 @web
  Scenario: Despublicar un post
    Given I have a version "<VERSION_APP>"
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having css selector "input[name='identification']"
    Then I enter "<PASSWORD>" into input field having css selector "input[name='password']"
    Then I click on element having css selector "button[type='submit']"
    Then I click on element having css selector "a[href='#/posts/']"
    Then I click on element having css selector ".gh-posts-list-item:nth-child(2)"
    Then I enter "Editar post con KRAKEN" into input field having css selector ".gh-editor-title"
    Then I enter "Cuerpo del mensaje de prueba editada" into input field having css selector ".koenig-editor__editor p" 
    Then I wait for 2 seconds
    Then I click on element having css selector ".gh-publishmenu"
    Then I click on element having css selector ".gh-publishmenu-radio:not(.active)"
    Then I click on element having css selector ".gh-publishmenu-button"
    Then I wait for 3 seconds
    Then I click on element having css selector ".gh-editor-back-button"
    Then I wait for 1 seconds
    Then I should see text "Posts"

