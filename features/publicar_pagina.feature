Feature: Función publicar página
  @user1 @web
  Scenario: Publicar una página
    Given I have a version "<VERSION_APP>"
    When I log in ghost local app as an administrator with this user "<EMAIL>" and password "<PASSWORD>"
    Then I click on element having css selector "a[href='#/pages/']"
    Then I click on element having css selector "a[href='#/editor/page/']"
    Then I enter "Publicación de página con KRAKEN" into input field having css selector ".gh-editor-title"
    Then I enter "Cuerpo del mensaje de prueba" into input field having css selector ".koenig-editor p"
    Then I click on element having css selector ".gh-publishmenu"
    Then I click on element having css selector ".gh-publishmenu-button"
    Then I wait for 3 seconds
    Then I should see text "Published"
    Then I click on element having css selector "button[title='Settings']"
    Then I click on element having css selector ".settings-menu-delete-button"
    Then I click on element having css selector ".gh-btn-red"
    Then I click on element having css selector ".gh-user-avatar"
    Then I click on element having css selector "a[href='#/signout/']"
