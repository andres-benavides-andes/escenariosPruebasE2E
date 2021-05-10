Feature: Función ver preview de una página
  @user1 @web
  Scenario: Ver preview de una página
    Given I navigate to page "http://localhost:2368/ghost/"
    Then I enter "<EMAIL>" into input field having css selector "input[name='identification']"
    Then I enter "<PASSWORD>" into input field having css selector "input[name='password']"
    Then I click on element having css selector "button[type='submit']"
    Then I click on element having css selector "a[href='#/pages/']"
    Then I click on element having css selector "a[href='#/editor/page/']"
    Then I enter "Ver preview de página con KRAKEN" into input field having css selector ".gh-editor-title"
    Then I enter "Cuerpo del mensaje de prueba" into input field having css selector ".koenig-editor p"
    Then I wait for 3 seconds
    Then I click on element having css selector "button[title='Settings']"
    Then I click on element having css selector ".post-view-link"
    Then I should see text "Ver preview de página con KRAKEN"
    Then I wait for 3 seconds
    Then I click on element having css selector ".settings-menu-delete-button"
    Then I click on element having css selector ".gh-btn-red"
    Then I click on element having css selector ".gh-user-avatar"
    Then I click on element having css selector "a[href='#/signout/']"